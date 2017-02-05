#ifndef MSA_STRING_HPP
#define MSA_STRING_HPP

#include <string>

namespace msa { namespace util {

	typedef std::string String;

	extern const String default_ws;

	extern String &left_trim(String &str, const String &search = default_ws);
	extern String &right_trim(String &str, const String &search = default_ws);
	extern String &trim(String &str, const String &search = default_ws);
	extern String &to_upper(String &str);
	extern String &to_lower(String &str);

} }

#endif
