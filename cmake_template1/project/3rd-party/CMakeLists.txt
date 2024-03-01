# Add Source file
set(PROJECT_SOURCES
	rt-thread/components/finsh/cmd.c
	rt-thread/components/finsh/msh_file.c
	rt-thread/components/finsh/msh_parse.c
	rt-thread/components/finsh/msh.c
	rt-thread/components/finsh/shell.c
	rt-thread/libcpu/arm/cortex-r8/armv7_gcc.S
	rt-thread/libcpu/arm/cortex-r8/context_gcc.S
	rt-thread/libcpu/arm/cortex-r8/core_timer.c
	rt-thread/libcpu/arm/cortex-r8/cp15_gcc.S
	rt-thread/libcpu/arm/cortex-r8/cpu.c
	rt-thread/libcpu/arm/cortex-r8/cpuport_smp.c
	rt-thread/libcpu/arm/cortex-r8/gic_gcc.S
	rt-thread/libcpu/arm/cortex-r8/gic.c
	rt-thread/libcpu/arm/cortex-r8/interrupt.c
	rt-thread/libcpu/arm/cortex-r8/scu_gcc.S
	rt-thread/libcpu/arm/cortex-r8/stack.c
	rt-thread/libcpu/arm/cortex-r8/startup_gcc.S
	rt-thread/libcpu/arm/cortex-r8/trap.c
	rt-thread/libcpu/arm/cortex-r8/vector_gcc.S
	rt-thread/src/clock.c
	rt-thread/src/components.c
	rt-thread/src/cpu.c
	rt-thread/src/idle.c
	rt-thread/src/ipc.c
	rt-thread/src/irq.c
	rt-thread/src/kservice.c
	rt-thread/src/mem.c
	rt-thread/src/memheap.c
	rt-thread/src/mempool.c
	rt-thread/src/object.c
	rt-thread/src/signal.c
	rt-thread/src/thread.c
	rt-thread/src/timer.c
)

file(STRINGS "${CMAKE_SOURCE_DIR}/out/jx-soc-haps-arm-cr8/rt-thread/rtconfig.h" CONFIG_RT_USING_SMP REGEX "^#define[ \t]+RT_USING_SMP")  
  
if(CONFIG_RT_USING_SMP)  
	set(PROJECT_SOURCES  ${PROJECT_SOURCES}  rt-thread/src/scheduler_mp.c)    
else()  
	set(PROJECT_SOURCES  ${PROJECT_SOURCES}  rt-thread/src/scheduler_up.c)  
endif()

# Generate Library Files
add_library(3rd-party ${PROJECT_SOURCES})

