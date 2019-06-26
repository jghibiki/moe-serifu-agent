import asyncio
from msa.data import start_db_engine
from msa.server.route_adapter import RouteAdapter
from msa.server.default_routes import register_default_routes

from aiohttp import web

# create global route adapter
route_adapter = RouteAdapter()
register_default_routes(route_adapter)


async def start_supervisor(app):
    app["supervisor"].start()

async def stop_supervisor(app):
    app["supervisor"].logger.info("*** trigger shutdown")
    await app["supervisor"].exit()


def start_server(config_context):
    app = web.Application()

    app["config_context"] = config_context

    # get loop and db
    loop = asyncio.get_event_loop()
    db = loop.run_until_complete(start_db_engine())

    # init supervisor
    from msa.core import supervisor
    app["supervisor"] = supervisor
    supervisor.init(loop, app["config_context"], db, route_adapter)

    app.add_routes(route_adapter.get_route_table())
    app.on_startup.append(start_supervisor)
    app.on_cleanup.append(stop_supervisor)
    web.run_app(app)