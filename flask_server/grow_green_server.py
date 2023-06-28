from flask import Flask, render_template, request, jsonify
from green_thumb_node import GreenThumbNode
from green_thumb_zone import GreenThumbZone
from database_functions import insert_node_sensor, insert_sensor_reading, insert_zone_sensor, update_node_name, update_node_threshold, update_zone_name, update_zone_pin, update_zone_threshold, new_sensor_check, remove_node, remove_zone, get_sensor_readings, get_nodes, get_zones
import sqlite3
import schedule
import threading
import time


app = Flask(__name__, static_url_path='/static')
DATABASE = 'sensor_data.db'
zone_dict = {4: 'Zone 1', 22: 'Zone 2', 27: 'Zone 3', 23: 'Zone 4', 24: 'Zone 5', 25: 'Zone 6'}
zone_pins = [4, 22, 27, 23, 24, 25]
zone_water_time = '06:00'
scheduled_job = None
sensor_names = []
g_t_zones = []
g_t_nodes = []

conn = sqlite3.connect(DATABASE)
cursor = conn.cursor()
cursor.execute('''CREATE TABLE IF NOT EXISTS readings (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    sensor_id TEXT,
                    moisture REAL,
                    battery_health REAL,
                    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
                    )''')
cursor.execute('''CREATE TABLE IF NOT EXISTS zones (
                    sensor_id TEXT,
                    display_name TEXT, 
                    threshold INT,
                    pin INT
                    )''')
cursor.execute('''CREATE TABLE IF NOT EXISTS nodes (
                    sensor_id TEXT,
                    display_name TEXT,
                    threshold INT
                    )''')
cursor.close()
conn.close()

def get_all_sensor_ids():
    conn = sqlite3.connect(DATABASE)
    cursor = conn.cursor()
    cursor.execute('SELECT DISTINCT sensor_id FROM readings')
    sensors = [row[0] for row in cursor.fetchall()]
    if len(g_t_zones) == 0:
        zones = get_zones()
        for zone in zones:
            new_zone = GreenThumbZone(zone['sensor_id'], zone['display_name'], zone['threshold'], zone['pin'], needs_water=False)
            g_t_zones.append(new_zone)
    if len(g_t_nodes) == 0:
        nodes = get_nodes()
        for node in nodes:
            new_node = GreenThumbNode(node['sensor_id'], node['display_name'], node['threshold'], needs_water=False)
            g_t_nodes.append(new_node)
    return sensors

def check_if_sensor_exists(sensor_id):
    if new_sensor_check(sensor_id):
        sensor_names.append(sensor_id)
        if 'node' in sensor_id.lower():
            #create new node and add it to the node list
            node = GreenThumbNode(sensor_id, sensor_id, threshold=70, needs_water=False)
            g_t_nodes.append(node)
            insert_node_sensor(node)
        elif 'zone' in sensor_id.lower():
            #create new zone and add it to the zone list
            zone = GreenThumbZone(sensor_id=sensor_id, display_name=sensor_id, threshold=70, pin=4, needs_water=False)
            g_t_zones.append(zone)
            insert_zone_sensor(zone)
        print(sensor_names)

def get_zone_from_list(sensor_id):
    for zone in g_t_zones:
        if zone.name == sensor_id:
            return zone
        
def get_node_from_list(sensor_id):
    for node in g_t_nodes:
        if node.name == sensor_id:
            return node
        
def update_when_to_water_zones(new_time):
    global zone_water_time, scheduled_job

    if scheduled_job:
        schedule.cancel_job(scheduled_job)

    zone_water_time = new_time
    scheduled_job = schedule.every().day.at(zone_water_time).do(water_zones)

def schedule_water():
    global scheduled_job
    scheduled_job = schedule.every().day.at(zone_water_time).do(water_zones)
    while True:
        schedule.run_pending()
        time.sleep(1)


def water_zones():
    print('Watering zones')
    for zone in g_t_zones:
        if zone.needs_water:
            zone.water_zone()

@app.route('/settings', methods=['GET'])
def settings_page():
    return render_template('settings_page.html')

@app.route('/zone-info')
def zone_info():
    display_name = request.args.get('display_name')  # Retrieve the display_name from the query parameter
    # Perform any additional logic or data retrieval based on the display_name
    return render_template('zone_info.html', display_name=display_name)

@app.route('/get-zone', methods=['GET'])
def get_zone():
    #TODO need to update with the correct information about the zone
    data = {
        'message': 'Hello, world!',
        'value': 42
    }
    return jsonify(data)

@app.route('/', methods=['GET'])
def home_page():
    #TODO need to update the zones with the actual zones from the database with the correct information
    zones = [
        {'zone_number': 'Zone 1', 'moisture': 50, 'display_name': 'Front Yard'},
        {'zone_number': 'Zone 2', 'moisture': 60, 'display_name': 'Side Yard'},
        {'zone_number': 'Zone 3', 'moisture': 70, 'display_name': 'Back Yard'},
        {'zone_number': 'Zone 4', 'moisture': 80, 'display_name': 'Guest Yard'},
        {'zone_number': 'Zone 5', 'moisture': 90, 'display_name': 'Cassita Yard'},
        {'zone_number': 'Zone 6', 'moisture': 95, 'display_name': 'Kids Yard'}
    ]
    return render_template('home_page.html', zones=zones)

@app.route('/sensor-data', methods=['POST'])
def insert_sensor_data():
    try:
        data = request.get_json()
        app.logger.info('Received JSON data: %s', data)  # Log the received data
        # Rest of your code...
        data = request.get_json()
        sensor_id = data['sensor_id']
        moisture = data['moisture']
        battery_health = data['battery_health']
        check_if_sensor_exists(sensor_id)
        insert_sensor_reading(sensor_id=sensor_id, moisture=moisture, battery_health=battery_health)
        if 'node' in sensor_id.lower():
            node = get_node_from_list(sensor_id)
            if moisture < node.threshold:
                node.needs_water = True
        if 'zone' in sensor_id.lower():
            zone = get_zone_from_list(sensor_id)
            if moisture < zone.threshold:
                zone.needs_water = True
        return jsonify('sensor data inserted')
    except Exception as e:
        app.logger.error('Error processing sensor data: %s', str(e))  # Log any exceptions
        return jsonify('Error processing sensor data'), 500  # Return a 500 error so the sensor knows it needs to resend

@app.route('/sensor-data', methods=['GET'])
def get_sensor_data():
    return jsonify(get_sensor_readings())

@app.route('/get-zones', methods=['GET'])
def get_zones_from_database():
    return jsonify(get_zones())

@app.route('/get-nodes', methods=['GET'])
def get_nodes_from_database():
    return jsonify(get_nodes())

@app.route('/update-threshold', methods=['POST'])
def update_threshold():
    data = request.get_json()
    sensor_id = data['sensor_id']
    new_threshold = data['threshold']
    if 'node' in sensor_id.lower():
        node = get_node_from_list(sensor_id)
        node.display_name = new_threshold
        update_node_threshold(node)
    elif 'zone' in sensor_id.lower():
        zone = get_zone_from_list(sensor_id)
        zone.display_name = new_threshold
        update_zone_threshold(node)
    return jsonify('new threshold')

@app.route('/update-zone-pin', methods=['POST'])
def update_zone_pin():
    data = request.get_json()
    sensor_id = data['sensor_id']
    new_pin = data['pin']
    zone = get_zone_from_list(sensor_id)
    zone.pin = new_pin
    update_zone_pin(zone)
    return jsonify('new zone pin')

@app.route('/update-display_name', methods=['POST'])
def update_display_name():
    data = request.get_json()
    sensor_id = data['sensor_id']
    new_name = data['display_name']
    if 'node' in sensor_id.lower():
        node = get_node_from_list(sensor_id)
        node.display_name = new_name
        update_node_name(node)
    elif 'zone' in sensor_id.lower():
        zone = get_zone_from_list(sensor_id)
        zone.display_name = new_name
        update_zone_name(zone)
    return jsonify('new display name')

@app.route('/remove-sensor', methods=['POST'])
def remove_sensor():
    data = request.get_json()
    sensor_id = data['sensor_id']
    #remove node from readings and nodes
    if 'node' in sensor_id.lower():
        node = get_node_from_list(sensor_id=sensor_id)
        remove_node(node=node)
    #remove zone from readings and zones
    elif 'zone' in sensor_id.lower():
        zone = get_zone_from_list(sensor_id=sensor_id)
        remove_zone(zone=zone)
    return jsonify('Sensor Removed From Control Hub')


@app.route('/time-to-water', methods=['GET', 'POST'])
def time_to_water():
    print('time to water')
    if request.method == 'GET':
        print('current time to water')
        #get the time that he zones are scheduled to run
        return jsonify(zone_water_time)
    elif request.method == 'POST':
        data = request.get_json()
        new_zone_start_time = data['time_to_water']
        update_when_to_water_zones(new_zone_start_time)
        #update scheduler to run at the new slected start time.
        print('setting new time to water')
        return jsonify('post request success')
    
    
if __name__ == '__main__':
    sensor_names = get_all_sensor_ids()
    schedule_thread = threading.Thread(target=schedule_water)
    schedule_thread.start()
    app.run(host='0.0.0.0', port=5050)