#ifndef SIGNPOST_WRAP_H_
#define SIGNPOST_WRAP_H_

#include <os/signpost.h>

#define signpost_event_emit(log, event_id, msg, ...) \
  os_signpost_event_emit(log, event_id, "python", "%s", msg)

#define signpost_interval_begin(log, interval_id, msg) \
  os_signpost_interval_begin(log, interval_id, "python", "%s", msg)

#define signpost_interval_end(log, interval_id, msg) \
  os_signpost_interval_end(log, interval_id, "python", "%s", msg)

#endif // SIGNPOST_WRAP_H_
