# We currently don't tests whether correct signposts are created, only if the
# API works.

import pytest

from os_signpost import Signposter


@pytest.fixture
def signposter():
    return Signposter("ai.explosion.signposter", Signposter.Category.DynamicTracing)


def test_context_manager(signposter):
    with signposter.use_interval(
        "begin test_context_manager", "end test_context_manager"
    ):
        ()

    with signposter.use_interval(
        "test_context_manager"
    ):
        ()


def test_emit_event(signposter):
    signposter.emit_event("test_emit_event")


def test_interval(signposter):
    end_interval = signposter.begin_interval("end test_interval")
    end_interval("end test_interval")

    end_interval = signposter.begin_interval("end test_interval")
    end_interval()
