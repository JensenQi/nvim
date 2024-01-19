from .resource import Resource


class DynamicResource:

    def __init__(self, template_file: str):
        self._resource = Resource.read(template_file)

    def set(self, key, value):
        self._resource.replace(key, value)
        return self

    def save(self, target_path: str):
        self._resource.write(target_path)
        return self
