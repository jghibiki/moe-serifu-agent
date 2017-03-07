#ifndef AGENT_HPP
#define AGENT_HPP

#include "msa.hpp"
#include "configuration.hpp"

#include <string>

// Moe Serifu Agent state and manipulation

namespace msa { namespace agent {

	typedef enum state_type { IDLE, ALERT, LISTEN, ERO, CONVERSE, DEBUG } State;
	typedef enum mood_type { NORMAL } Mood;

	typedef struct agent_type
	{
		// name of the agent
		const std::string name;

		// current activity
		State state;
		
		// positive attitude to the master user,
		// TODO: make this into an ID->attitude table
		uint32_t attitude;
			
		// current emotional state, affected by context and responses
		Mood mood;

		// creates a new agent, n is the name of the agent
		agent_type(const std::string &n);
	} Agent;

	extern int init(msa::Handle hdl, const msa::config::Section &config);
	extern int quit(msa::Handle hdl);
	extern void say(msa::Handle hdl, const std::string &text);
	extern const Agent *get_agent(msa::Handle hdl);
	
} }
#endif
