#ifndef COMPAT_PLATFORM_FILE_FILE_HPP
#define COMPAT_PLATFORM_FILE_FILE_HPP

#include <string>
#include <vector>

// functions for manipulating the filesystem in a cross-platform way

namespace msa { namespace file {

	extern void list(const std::string &dir_path, std::vector<std::string> &files);
	extern const std::string &dir_separator();
	extern void join(std::string &base, const std::string &next);
	extern void basename(std::string &path, const std::string &suffix = "");

} }

#endif
