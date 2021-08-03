#!/bin/env python3
try:
    import dbus
    import sys
except ImportError:
    import sys
    print("Installier dbus via pip")
    sys.exit(-1)


class Player:

    _name = None
    _service = None
    _player = None
    _interface = None
    _bus = dbus.SessionBus()
    _info = {}
    _trackMap = {
        'trackid': 'mpris:trackid',
        'length': 'mpris:length',
        'artUrl': 'mpris:artUrl',
        'album': 'xesam:album',
        'artist': 'xesam:artist',
        'title': 'xesam:title',
        'url': 'xesam:url',
        'rating': 'xesam:autoRating',
        'status': 'PlaybackStatus',
    }

    def __init__(self, service):
        self._service = service
        self._name = service.split('.')[-1]
        self._player = self._bus.get_object(self._service,
                                            '/org/mpris/MediaPlayer2')
        self._interface = dbus.Interface(
            self._player, dbus_interface='org.freedesktop.DBus.Properties')
        self.get_metadata()

    def __repr__(self):
        return "{} - {} - {}".format(
             shorter(self.get_value(self._trackMap['title'])),
             shorter(self.get_value(self._trackMap['artist'])),
             shorter(self.get_value(self._trackMap['album'])))

    # Get all availables information from DBus for a player object
    def get_metadata(self):
        self._info = {}
        metadata = self._interface.GetAll('org.mpris.MediaPlayer2.Player')
        for key, val in metadata.items():
            if isinstance(val, dict):
                for subk, subv in val.items():
                    self._info[subk] = subv
            self._info[key] = val

    def is_playing(self):
        return self._info['PlaybackStatus'] == 'Playing'

    def next(self):
        dbus.Interface(
            self._player,
            dbus_interface='org.mpris.MediaPlayer2.Player').Next()

    def prev(self):
        dbus.Interface(
            self._player,
            dbus_interface='org.mpris.MediaPlayer2.Player').Previous()

    def play_pause(self):
        dbus.Interface(
            self._player,
            dbus_interface='org.mpris.MediaPlayer2.Player').PlayPause()

    def stop(self):
        dbus.Interface(
            self._player,
            dbus_interface='org.mpris.MediaPlayer2.Player').Stop()

    def get_value(self, key):
        try:
            value = self._info[key]
            if isinstance(value, int):
                import datetime
                return str(datetime.timedelta(microseconds=value))

            return ''.join(self._info[key])
        except KeyError:
            return ''


players = {}
dmask = ["-", ":", "(","/"]


def getnumber(iterator):
    try:
        return min([s for s in iterator if s >= 0])
    except ValueError:
        return 0


def shorter(liste, mask=dmask):
    result = [liste.find(s) for s in mask]
    index = getnumber(result)
    if index == 0:
        return(liste)
    elif index >= 25:
        return(liste[0:25])
    else:
        return(liste[0:index])

def get_services(name):
    global players

    def test(service):
        return name in service or 'org.mpris.MediaPlayer2' in service

    try:
        players = {
            str(service.split('.')[-1]): Player(service)
            for service in dbus.SessionBus().list_names() if test(service)
        }
    except:
        pass


if __name__ == '__main__':
    service = "spotify"
    get_services(service)
    try:
        p = players["spotify"]
        if sys.argv[1] == 'next':
            p.next()
        elif sys.argv[1] == 'prev':
            p.prev()
        elif sys.argv[1] == 'play':
            if not p.is_playing():
                p.play_pause()
        elif sys.argv[1] == 'pause':
            if p.is_playing():
                p.play_pause()
        elif sys.argv[1] == 'toggleplay':
            p.play_pause()
        # elif sys.argv[1] == 'stop':
        #     p.stop()
    except IndexError:
        print(p)
    except KeyError:
        print("")

