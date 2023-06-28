import sqlite3
from green_thumb_zone import GreenThumbZone
from green_thumb_node import GreenThumbNode

DATABASE = 'sensor_data.db'

def get_db():
    conn = sqlite3.connect(database=DATABASE)
    return conn

def new_sensor_check(sensor_id):
    conn = get_db()
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM readings')
    rows = cursor.fetchall()
    for row in rows:
        if row[1] == sensor_id:
            return False
    cursor.close()
    conn.close()    
    return True

def get_sensor_readings():
    conn = get_db()
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM readings')
    rows = cursor.fetchall()
    readings = []
    for row in rows:
        reading = {
            'id': row[0],
            'sensor_id': row[1],
            'moisture': row[2],
            'battery_health': row[3],   
            'timestamp': row[4]         
            }
        readings.append(reading)
    cursor.close()    
    conn.close()
    return readings

def get_nodes():
    conn = get_db()
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM nodes')
    rows = cursor.fetchall()
    nodes = []
    for row in rows:
        node = {
            'sensor_id': row[0],
            'display_name': row[1],
            'threshold': row[2]
        }
        nodes.append(node)
    cursor.close()
    conn.close()
    return nodes

def get_zones():
    conn = get_db()
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM zones')
    rows = cursor.fetchall()
    zones = []
    for row in rows:
        zone = {
            'sensor_id': row[0],
            'display_name': row[1],
            'threshold': row[2],
            'pin': row[3]
        }
        zones.append(zone)
    cursor.close()
    conn.close()
    return zones

def insert_sensor_reading(sensor_id, moisture, battery_health):
    conn = get_db()
    cursor = conn.cursor()
    cursor.execute('INSERT INTO readings (sensor_id, moisture, battery_health) VALUES (?, ?, ?)', (sensor_id, moisture, battery_health))
    conn.commit()
    cursor.close()
    conn.close()

def insert_zone_sensor(zone: GreenThumbZone):
    conn = get_db()
    cursor = conn.cursor()
    cursor.execute('INSERT INTO zones (sensor_id, display_name, threshold, pin) VALUES (?, ?, ?, ?)', (zone.name, zone.display_name, zone.threshold, zone.pin))
    conn.commit()
    cursor.close()
    conn.close()

def insert_node_sensor(node: GreenThumbNode):
    conn = get_db()
    cursor = conn.cursor()
    cursor.execute('INSERT INTO nodes (sensor_id, display_name, threshold) VALUES (?, ?, ?)', (node.name, node.display_name, node.threshold))
    conn.commit()
    cursor.close()
    conn.close()

def update_zone_name(zone: GreenThumbZone):
    conn = get_db()
    cursor = conn.cursor()
    cursor.execute('UPDATE zones SET display_name = ? WHERE sensor_id = ?', (zone.display_name, zone.name))
    conn.commit()
    cursor.close()
    conn.close()

def update_zone_threshold(zone: GreenThumbZone):
    conn = get_db()
    cursor = conn.cursor()
    cursor.execute('UPDATE zones SET threshold = ? WHERE sensor_id = ?', (zone.threshold, zone.name))
    conn.commit()
    cursor.close()
    conn.close()

def update_zone_pin(zone: GreenThumbZone):
    conn = get_db()
    cursor = conn.cursor()
    cursor.execute('UPDATE zones SET pin = ? WHERE sensor_id = ?', (zone.pin, zone.name))
    conn.commit()
    cursor.close()
    conn.close()

def update_node_name(node: GreenThumbNode):
    conn = get_db()
    cursor = conn.cursor()
    cursor.execute('UPDATE nodes SET display_name = ? WHERE sensor_id = ?', (node.display_name, node.name))
    conn.commit()
    cursor.close()
    conn.close()

def update_node_threshold(node: GreenThumbNode):
    conn = get_db()
    cursor = conn.cursor()
    cursor.execute('UPDATE nodes SET threshold = ? WHERE sensor_id = ?', (node.threshold, node.name))
    conn.commit()
    cursor.close()
    conn.close()

def remove_zone(zone: GreenThumbZone):
    conn = get_db()
    cursor = conn.cursor()
    cursor.execute('DELETE FROM readings WHERE sensor_id = ?', (zone.name))
    cursor.execute('DELETE FROM zones WHERE sensor_id = ?', (zone.name))
    conn.commit()
    cursor.close()
    conn.close()

def remove_node(node: GreenThumbNode):
    conn = get_db()
    cursor = conn.cursor()
    cursor.execute('DELETE FROM readings WHERE sensor_id = ?', (node.name))
    cursor.execute('DELETE FROM nodes WHERE sensor_id = ?', (node.name))
    conn.commit()
    cursor.close()
    conn.close()
    