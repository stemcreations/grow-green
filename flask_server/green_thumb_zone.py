class GreenThumbZone:
    def __init__(self, sensor_id, display_name, threshold, pin, needs_water):
        self.name = sensor_id
        self._display_name = display_name
        self._threshold = threshold
        self._pin = pin
        self._needs_water = needs_water
    
    @property
    def display_name(self):
        return self._display_name
    
    @display_name.setter
    def display_name(self, value):
        self._display_name = value
    
    @property
    def threshold(self):
        return self._threshold
    
    @threshold.setter
    def threshold(self, value):
        self._threshold = value
    
    @property
    def pin(self):
        return self._pin
    
    @pin.setter
    def pin(self, value):
        self._pin = value

    @property
    def needs_water(self):
        return self._needs_water
    
    @needs_water.setter
    def needs_water(self, value):
        self._needs_water = value

    def water_zone(self):
        #create a watering system that turns on and off GPIO PINS
        self._needs_water = False
        print('zone watered')