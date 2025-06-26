class cuda:
    @staticmethod
    def is_available():
        return False

    @staticmethod
    def device_count():
        return 0

    @staticmethod
    def get_device_name(i):
        return f"GPU-{i}"

def device(name):
    return name

def rand(*shape, device=None):
    return [[0]*shape[-1]]*shape[0]

def mm(a, b):
    return a
__version__='0.0'
