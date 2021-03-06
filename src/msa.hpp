#ifndef MSA_MSA_HPP
#define MSA_MSA_HPP

#include "debug_macros.hpp"

// DO NOT INCLUDE ANY MSA HEADER FILES HERE!
// If you find you have to, re-think your design.
// It will break here.

#define MSA_SUCCESS 0
#define MSA_ERR_EVENT 1
#define MSA_ERR_INPUT 2
#define MSA_ERR_AGENT 3
#define MSA_ERR_CONFIG 4
#define MSA_ERR_CMD 5
#define MSA_ERR_LOG 6
#define MSA_ERR_OUTPUT 7
#define MSA_ERR_PLUGIN 8

namespace msa {

	namespace input {

		typedef struct input_context_type InputContext;
		typedef struct plugin_hooks_type PluginHooks;

	}

	namespace output {

		typedef struct output_context_type OutputContext;
		typedef struct plugin_hooks_type PluginHooks;

	}

	namespace event {
		
		typedef struct event_dispatch_context_type EventDispatchContext;
		struct TimerContext;
		typedef struct plugin_hooks_type PluginHooks;
		
	}

	namespace agent {

		typedef struct agent_context_type AgentContext;
		typedef struct plugin_hooks_type PluginHooks;

	}

	namespace cmd {

		typedef struct command_context_type CommandContext;
		typedef struct plugin_hooks_type PluginHooks;

	}

	namespace log {

		typedef struct log_context_type LogContext;
		typedef struct plugin_hooks_type PluginHooks;

	}
	
	namespace plugin {
	
		typedef struct plugin_context_type PluginContext;
		typedef struct plugin_hooks_type PluginHooks;
		
	}

	enum class Status
	{
		CREATED,
		RUNNING,
		STOP_REQUESTED,
		STOPPED
	};	

	struct environment_type
	{
		Status status;
		msa::event::EventDispatchContext *event;
		// timer is not actually a separate module from event, but we give it special status
		// because it must be able to get its context without relying on the event dispatch
		// module.
		msa::event::TimerContext *timer; 
		msa::input::InputContext *input;
		msa::output::OutputContext *output;
		msa::agent::AgentContext *agent;
		msa::cmd::CommandContext *cmd;
		msa::log::LogContext *log;
		msa::plugin::PluginContext *plugin;
	};

	typedef struct environment_type* Handle;
	
	typedef struct plugin_hooks_type
	{
		const msa::event::PluginHooks *event;
		const msa::input::PluginHooks *input;
		const msa::output::PluginHooks *output;
		const msa::agent::PluginHooks *agent;
		const msa::cmd::PluginHooks *cmd;
		const msa::log::PluginHooks *log;
		const msa::plugin::PluginHooks *plugin;
	} PluginHooks;

	// global library initializer. Must call before creating handles with start()
	extern void init();
	
	// starts an MSA instance.
	extern int start(Handle *hdl, const char *config_path);
	
	// global library destructor. Must call in order to free global resources. Do
	// not call until all handles have been properly released with dispose()
	extern void quit();
	
	// stops an MSA instance. This will invalidate most of the environment but the
	// status will still be accessible. Use dispose() to completely free the
	// handle.
	extern int stop(Handle hdl);
	
	// disposes a handle. Do not call on an active MSA handle; call stop() on
	// that handle first.
	extern int dispose(Handle hdl);

	// gets the global plugin hooks table
	extern const PluginHooks *get_plugin_hooks();

}

#endif
