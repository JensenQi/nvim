from .resource import Resource


class StaticResource:

    def __init__(self, file_name: str):
        self._resource = Resource.copy(file_name)

    def save(self, target_path: str):
        self._resource.to(target_path)
        return self
