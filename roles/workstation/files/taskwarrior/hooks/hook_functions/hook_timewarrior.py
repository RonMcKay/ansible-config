# Standard Library
from copy import deepcopy
import subprocess


def hook_timewarrior(new: dict, old: dict = None) -> dict:
    # only start time tracking if the current area is Work (w)
    # and it is a modify event, thus an old task is supplied
    if new.get('area', '') == 'w' and old is not None:

        start_or_stop = ''

        # Started task.
        if 'start' in new and 'start' not in old:
            start_or_stop = 'start'

        # Stopped task.
        elif ('start' not in new or 'end' in new) and 'start' in old:
            start_or_stop = 'stop'

        if start_or_stop:
            tags = get_timewarrior_tags(new)

            subprocess.call(['timew', start_or_stop] + tags + [':yes'])

        # Modifications to task other than start/stop
        elif 'start' in new and 'start' in old:
            old_tags = get_timewarrior_tags(old)
            new_tags = get_timewarrior_tags(new)

            if old_tags != new_tags:
                pass
                subprocess.call(['timew', 'untag', '@1'] + old_tags + [':yes'])
                subprocess.call(['timew', 'tag', '@1'] + new_tags + [':yes'])
    return new

###########################################################
# Utils


def split_project(json_object: dict) -> list:
    if 'project' in json_object:
        return json_object.get('project').split('.')
    else:
        return []


def get_timewarrior_tags(json_object: dict) -> list:
    tags = deepcopy(json_object.get('tags', []))
    tags.extend(split_project(json_object))
    if 'person' in json_object:
        tags.extend(json_object['person'].split(','))
    return list(set(tags))
