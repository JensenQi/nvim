from os.path import isdir
from .resource import Resource


class StaticResource:

    def __init__(self, file_name: str):
        self._resource = Resource.copy(file_name)

    def save(self, target_path: str):
        if isdir(self._resource.source_path):
            self._resource.to(target_path, recursive=True)
        else:
            self._resource.to(target_path)
        return self

