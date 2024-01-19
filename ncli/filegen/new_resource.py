from .resource import Resource


class NewResource:

    def __init__(self, content):
        self._resource = Resource.create(content)

    def set(self, key, value):
        self._resource.replace(key, value)
        return self

    def save(self, target_path: str):
        self._resource.write(target_path)
        return self
