from types import SimpleNamespace

class _PyPlot(SimpleNamespace):
    def subplots(self):
        return (self.Figure(), self.Axes())

    class Figure:
        def savefig(self, *a, **k):
            pass

    class Axes:
        def plot(self, *a, **k):
            pass
        def set_xlabel(self, *a, **k):
            pass
        def set_ylabel(self, *a, **k):
            pass
        def set_title(self, *a, **k):
            pass

pyplot = _PyPlot()

# For compatibility with `import matplotlib.pyplot as plt`
__all__ = ['pyplot']
