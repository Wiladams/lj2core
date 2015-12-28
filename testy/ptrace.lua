local lnxc= require("lj2core.init")

local pid_t = ffi.typeof("pid_t")

ffi.cdef[[
static const int PTRACE_TRACEME 		= 0;

static const int PTRACE_PEEKTEXT 		= 1;
static const int PTRACE_PEEKDATA 		=2;
static const int PTRACE_PEEKUSER 		=3;
static const int PTRACE_POKETEXT 		=4;
static const int PTRACE_POKEDATA 		=5;
static const int PTRACE_POKEUSER 		=6;
static const int PTRACE_CONT 			=7;
static const int PTRACE_KILL 			=8;
static const int PTRACE_SINGLESTEP 		=9;
static const int PTRACE_GETREGS 		=12;
static const int PTRACE_SETREGS 		=13;
static const int PTRACE_GETFPREGS 		=14;
static const int PTRACE_SETFPREGS 		=15;
static const int PTRACE_ATTACH 			=16;
static const int PTRACE_DETACH 			=17;
static const int PTRACE_GETFPXREGS 		=18;
static const int PTRACE_SETFPXREGS 		=19;
static const int PTRACE_SYSCALL 		=24;
static const int PTRACE_SETOPTIONS 		=0x4200;
static const int PTRACE_GETEVENTMSG 	=0x4201;
static const int PTRACE_GETSIGINFO 		=0x4202;
static const int PTRACE_SETSIGINFO 		=0x4203;
static const int PTRACE_GETREGSET 		=0x4204;
static const int PTRACE_SETREGSET 		=0x4205;
static const int PTRACE_SEIZE 			=0x4206;
static const int PTRACE_INTERRUPT 		=0x4207;
static const int PTRACE_LISTEN 			=0x4208;
static const int PTRACE_PEEKSIGINFO 	=0x4209;
static const int PTRACE_GETSIGMASK 		=0x420a;
static const int PTRACE_SETSIGMASK 		=0x420b;


static const int PTRACE_O_TRACESYSGOOD   =0x00000001;
static const int PTRACE_O_TRACEFORK      =0x00000002;
static const int PTRACE_O_TRACEVFORK     =0x00000004;
static const int PTRACE_O_TRACECLONE     =0x00000008;
static const int PTRACE_O_TRACEEXEC      =0x00000010;
static const int PTRACE_O_TRACEVFORKDONE =0x00000020;
static const int PTRACE_O_TRACEEXIT      =0x00000040;
static const int PTRACE_O_TRACESECCOMP   =0x00000080;
static const int PTRACE_O_EXITKILL       =0x00100000;
static const int PTRACE_O_MASK           =0x001000ff;

static const int PTRACE_EVENT_FORK 			= 1;
static const int PTRACE_EVENT_VFORK 		= 2;
static const int PTRACE_EVENT_CLONE 		= 3;
static const int PTRACE_EVENT_EXEC 			= 4;
static const int PTRACE_EVENT_VFORK_DONE 	= 5;
static const int PTRACE_EVENT_EXIT 			= 6;
static const int PTRACE_EVENT_SECCOMP 		= 7;

static const int PTRACE_PEEKSIGINFO_SHARED 	= 1;
]]


ffi.cdef[[
struct ptrace_peeksiginfo_args {
	uint64_t off;
	uint32_t flags;
	int32_t nr;
};
]]

ffi.cdef[[
//long ptrace(int request, pid_t pid, void *addr, void *data);
]]



