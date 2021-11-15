# Standard Library
import subprocess

default_context_attributes = dict(
    work=dict(
        area='w'
    ),
    teaching=dict(
        area='w'
    ),
    research=dict(
        area='w'
    ),
    private=dict(
        area='p'
    ),
)


def hook_context_default(new: dict, old: dict = None):
    # only execute when a task was added, thus old=None
    if old is None:
        context = subprocess.run(
            ["task _show | grep context="],
            capture_output=True, text=True, shell=True
        ).stdout.strip().split('=')[-1]
        defaults_applied = False
        if context in default_context_attributes:
            for att_name, att_value in default_context_attributes[context].items():
                if att_name not in new:
                    new[att_name] = att_value
                    defaults_applied = True
            if defaults_applied:
                print("Default context values have been applied.")
    return new
