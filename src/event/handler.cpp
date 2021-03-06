#include "event/handler.hpp"

#include "platform/thread/thread.hpp"

namespace msa { namespace event {

	struct handler_synchronization_type {
		msa::thread::Cond resume_cond;
		msa::thread::Mutex suspend_mutex;
		bool suspend_flag;
		bool in_wait_loop;
		bool syscall_origin;
	};

	extern void create_handler_sync(HandlerSync **sync)
	{
		handler_synchronization_type *handler_sync = new handler_synchronization_type;
		msa::thread::cond_init(&handler_sync->resume_cond, NULL);
		msa::thread::mutex_init(&handler_sync->suspend_mutex, NULL);
		handler_sync->suspend_flag = false;
		handler_sync->in_wait_loop = false;
		handler_sync->syscall_origin = false;
		*sync = handler_sync;
	}

	extern void dispose_handler_sync(HandlerSync *sync)
	{
		msa::thread::cond_destroy(&sync->resume_cond);
		msa::thread::mutex_destroy(&sync->suspend_mutex);
		delete sync;
	}

	extern void suspend_handler(HandlerSync *sync)
	{
		msa::thread::mutex_lock(&sync->suspend_mutex);
		sync->suspend_flag = true;
		msa::thread::mutex_unlock(&sync->suspend_mutex);
	}

	extern void resume_handler(HandlerSync *sync)
	{
		msa::thread::mutex_lock(&sync->suspend_mutex);
		sync->suspend_flag = false;
		msa::thread::cond_broadcast(&sync->resume_cond);
		msa::thread::mutex_unlock(&sync->suspend_mutex);
	}

	extern bool handler_suspended(HandlerSync *sync)
	{
		msa::thread::mutex_lock(&sync->suspend_mutex);
		bool suspended = sync->in_wait_loop;
		msa::thread::mutex_unlock(&sync->suspend_mutex);
		return suspended;
	}

	extern void set_handler_syscall_origin(HandlerSync *sync)
	{
		sync->syscall_origin = true;
	}

	extern void clear_handler_syscall_origin(HandlerSync *sync)
	{
		sync->syscall_origin = false;
	}

	extern bool handler_syscall_origin(HandlerSync *sync)
	{
		return sync->syscall_origin;
	}

	extern void HANDLER_INTERRUPT_POINT(HandlerSync *sync)
	{
		msa::thread::mutex_lock(&sync->suspend_mutex);
		while (sync->suspend_flag)
		{
			sync->in_wait_loop = true;
			msa::thread::cond_wait(&sync->resume_cond, &sync->suspend_mutex);
		}
		sync->in_wait_loop = false;
		msa::thread::mutex_unlock(&sync->suspend_mutex);
	}

} }
