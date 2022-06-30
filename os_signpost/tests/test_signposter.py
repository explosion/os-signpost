# We currently don't tests whether correct signposts are created, only if the
# API works.

import pytest

from os_signpost import SignPoster


@pytest.fixture
def signposter():
    return SignPoster("ai.explosion.signposter", SignPoster.Category.DynamicTracing)


def test_context_manager(signposter):
    with signposter.use_interval(
        "begin test_context_manager", "end test_context_manager"
    ):
        ()


def test_emit_event(signposter):
    signposter.emit_event("test_emit_event")


def test_interval(signposter):
    end_interval = signposter.begin_interval("end test_interval")
    end_interval("end test_interval")
