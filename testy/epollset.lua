local ffi = require("ffi")
local bit = require("bit")
local lshift, rshift = bit.lshift, bit.rshift
local lnxc = require("lj2core.init")


local function octal(str)
	return tonumber(str, 8)
end

local C = {}
C.EPOLL_CLOEXEC = octal('02000000');
C.EPOLLIN 	= 0x0001;
C.EPOLLPRI 	= 0x0002;
C.EPOLLOUT 	= 0x0004;
C.EPOLLRDNORM = 0x0040;			-- SAME AS EPOLLIN
C.EPOLLRDBAND = 0x0080;
C.EPOLLWRNORM = 0x0100;			-- SAME AS EPOLLOUT
C.EPOLLWRBAND = 0x0200;
C.EPOLLMSG	= 0x0400;			-- NOT USED
C.EPOLLERR 	= 0x0008;
C.EPOLLHUP 	= 0x0010;
C.EPOLLRDHUP 	= 0x2000;
C.EPOLLWAKEUP = lshift(1,29);
C.EPOLLONESHOT = lshift(1,30);
C.EPOLLET 	= lshift(1,31);

-- Valid opcodes ( "op" parameter ) to issue to epoll_ctl().
C.EPOLL_CTL_ADD =1;	-- Add a file descriptor to the interface.
C.EPOLL_CTL_DEL =2;	-- Remove a file descriptor from the interface.
C.EPOLL_CTL_MOD =3;	-- Change file descriptor epoll_event structure.

ffi.cdef[[
struct epollset {
	int epfd;		// epoll file descriptor
} ;
]]

local epollset = ffi.typeof("struct epollset")
local epollset_mt = {
	__new = function(ct, epfd)
		if not epfd then
			epfd = lnxc.epoll_create1(0);
			print("epollset.__new(): ", epfd)
		end

		if epfd < 0 then
			return nil;
		end

		return ffi.new(ct, epfd)
	end,

	__gc = function(self)
		-- ffi.C.close(self.epfd);
	end;

	__index = {
		add = function(self, fd, event)
			local ret = lnxc.epoll_ctl(self.epfd, C.EPOLL_CTL_ADD, fd, event)
print("epollset.add(), fd,  event, ret: ", fd, event, ret, F.strerror());
			if ret > -1 then
				return ret;
			end

			return false, ffi.errno();
		end,

		delete = function(self, fd, event)
			local ret = lnxc.epoll_ctl(self.epfd, C.EPOLL_CTL_DEL, fd, event)

			if ret > -1 then
				return ret;
			end

			return false, ffi.errno();
		end,

		modify = function(self, fd, event)
			local ret = lnxc.epoll_ctl(self.epfd, C.EPOLL_CTL_MOD, fd, event)
			if ret > -1 then
				return ret;
			end

			return false, ffi.errno();
		end,

		-- struct epoll_event *__events
		wait = function(self, events, maxevents, timeout)
			maxevents = maxevents or 1
			timeout = timeout or -1

			-- gets either number of ready events
			-- or -1 indicating an error
			local ret = lnxc.epoll_wait (self.epfd, events, maxevents, timeout);
			if ret == -1 then
				return false, ffi.errno();
			end

			return ret;
		end,
	};
}
ffi.metatype(epollset, epollset_mt);

return epollset;
