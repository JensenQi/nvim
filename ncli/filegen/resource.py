import os
from typing import Optional
import shutil


class Resource(object):

    def __init__(self, file_name: str):
        super(Resource, self).__init__()
        current_file_path = os.path.dirname(os.path.realpath(__file__))
        self.source_path = f"{current_file_path}/../resources/{file_name}"
        self.content: Optional[str] = None

    @staticmethod
    def create(content):
        resource = Resource("buffer")
        resource.content = content
        return resource

    @staticmethod
    def read(file_name: str):
        resource = Resource(file_name)
        with open(resource.source_path, "r", encoding="utf8") as fp:
            resource.content = "".join(fp.readlines())
        return resource

    def replace(self, key: str, value: str):
        if self.content is not None:
            self.content = self.content.replace('{'+key+'}', value)
        else:
            raise Exception("content not found, call Resource.read first")
        return self

    def write(self, target_path):
        target_dir = os.path.dirname(target_path)
        if not os.path.exists(target_dir):
            os.makedirs(target_dir, exist_ok=True)
        if self.content is not None:
            with open(target_path, "w", encoding="utf8") as fp:
                fp.writelines(self.content)

    @staticmethod
    def copy(file_name: str):
        resource = Resource(file_name)
        return resource

    def to(self, target_path: str, recursive=False):
        target_dir = os.path.dirname(target_path)
        if not os.path.exists(target_dir):
            os.makedirs(target_dir, exist_ok=True)
        if recursive:
            shutil.copytree(self.source_path, target_path)
        else:
            shutil.copy(self.source_path, target_path)

