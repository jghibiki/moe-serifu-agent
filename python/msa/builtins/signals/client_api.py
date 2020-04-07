
from msa.core.event import Event

async def trigger_event(self, event):
    """
    Takes an `msa.core.event.Event` subclass to propagate to the daemon.

    :param msa.core.event.Event event: The event to propagate to the daemon. `event.network_propagate` must be set to
        `True`, otherwise the event will not be propagated.
    :return: `None`
    """
    if not event.network_propagate:
        print("WARNING: event.network_propagate is not True, cancelling network propagation.")

    response = await self.client.post(
        "/signals/trigger_event",
        payload=event.get_metadata())

    if not response:
        return
    if response.status_code != 200:
        raise Exception(response.raw)


async def get_events(self):
    """
    Fetches any events that have not been dispersed to clients.

    :return: List[msa.core.event.Event]
    """
    response = await self.client.get("/signals/events")

    if not response:
        return
    if response.status_code != 200:
        raise Exception(response.raw)

    # load response json
    json = response.json()

    # load disburse event
    disburse_event = Event.deserialize(json)

    # load sent events
    deserialized_events = []
    for raw_event in disburse_event.data["events"]:
        new_event = Event.deserialize(raw_event)
        deserialized_events.append(new_event)

    return deserialized_events


def register_endpoints(api_binder):

    api_binder.register_method(trigger_event)
    api_binder.register_method(get_events)
