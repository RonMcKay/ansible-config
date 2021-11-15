# Standard Library
from datetime import datetime, time, timezone

# Thirdparty libraries
import dateutil.parser
from tzlocal.unix import get_localzone

DEFAULT_TIME = time(19, 0, 0)


def is_local_midnight(timestamp: datetime) -> bool:
    return timestamp.astimezone(get_localzone()).time() == time(0, 0, 0)


def set_default_time(timestamp: datetime) -> datetime:
    return timestamp.astimezone(get_localzone()).replace(
        hour=DEFAULT_TIME.hour,
        minute=DEFAULT_TIME.minute,
        second=DEFAULT_TIME.second,
    ).astimezone(timezone.utc)


def hook_default_time(new: dict, old: dict = None) -> dict:
    if new.get('due', False):
        timestamp = dateutil.parser.parse(new.get('due'))
        if is_local_midnight(timestamp):
            new['due'] = set_default_time(timestamp).strftime(r'%Y%m%dT%H%M%SZ')
            print("Default due time has been set.")

    return new
