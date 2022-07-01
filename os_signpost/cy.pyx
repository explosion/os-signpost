# cython: infer_types=True
# cython: cdivision=True

from typing import Callable, Optional, Union
import contextlib
from enum import Enum


class _Category(Enum):
    PointsOfInterest = "PointsOfInterest"
    DynamicTracing = "DynamicTracing"
    DynamicStackTracing = "DynamicStackTracing"


cdef class Signposter:
    Category = _Category

    def __init__(self, subsystem: str, category: Union[Category, str]):
        if isinstance(category, self.Category):
            category = category.value

        # os_log_create will always return a value
        self.os_log = os_log_create(subsystem.encode('UTF-8') , category.encode('UTF-8') )

    def emit_event(self, msg: str):
        cdef os_signpost_id_t sid = os_signpost_id_generate(self.os_log)
        signpost_event_emit(self.os_log, sid, msg.encode("UTF-8"))

    def begin_interval(self, msg) -> Callable[[Optional[str]], None]:
        cdef os_signpost_id_t sid = os_signpost_id_generate(self.os_log)
        signpost_interval_begin(self.os_log, sid, msg.encode("UTF-8"))

        def end_interval(end_msg=None):
            if end_msg is None:
                end_msg = msg

            signpost_interval_end(self.os_log, sid, end_msg.encode("UTF-8"))

        return end_interval

    @contextlib.contextmanager
    def use_interval(self, begin_msg: str, end_msg: Optional[str]=None):
        if end_msg is None:
            end_msg = begin_msg

        end_interval = self.begin_interval(begin_msg)
        yield
        end_interval(end_msg)
