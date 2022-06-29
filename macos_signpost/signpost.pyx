# cython: infer_types=True
# cython: cdivision=True

from typing import Callable
import contextlib

cdef class OSLog:
    def __init__(self, subsystem: str, category: str):
        # os_log_create will always return a value
        self.os_log = os_log_create(subsystem.encode('UTF-8') , category.encode('UTF-8') )

    def signpost_interval(self, msg) -> Callable[[str], None]:
        cdef os_signpost_id_t sid = os_signpost_id_generate(self.os_log)
        signpost_interval_begin(self.os_log, sid, msg.encode("UTF-8"))

        def interval_end(msg):
            signpost_interval_end(self.os_log, sid, msg.encode("UTF-8"))

        return interval_end


@contextlib.contextmanager
def signpost_interval(log: OSLog, begin_msg: str, end_msg: str):
    interval_end = log.signpost_interval(begin_msg)
    yield
    interval_end(end_msg)
