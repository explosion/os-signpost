from libc.stdint cimport uint8_t, uint64_t

cdef extern from "os/log.h":
    cdef struct os_log_s
    ctypedef os_log_s* os_log_t;
    os_log_t os_log_create(const char *subsystem, const char *category)

cdef extern from "os/signpost.h":
    ctypedef uint8_t os_signpost_type
    ctypedef uint64_t os_signpost_id_t


    os_signpost_id_t os_signpost_id_generate(os_log_t log)

cdef extern from "signpost_wrap.h":
    void signpost_event_emit(os_log_t log, os_signpost_id_t event_id, const char* msg)
    void signpost_interval_begin(os_log_t log, os_signpost_id_t interval_id, const char* msg)
    void signpost_interval_end(os_log_t log, os_signpost_id_t interval_id, const char* msg)

cdef class Signposter:
    cdef os_log_t os_log
