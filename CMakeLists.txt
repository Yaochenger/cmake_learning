CMAKE_MINIMUM_REQUIRED(VERSION 3.10)

SET(CMAKE_SYSTEM_NAME Generic)
SET(CMAKE_SYSTEM_PROCESSOR cortex-r8)

SET(CMAKE_EXPORT_COMPILE_COMMANDS ON)
include_directories(${CMAKE_SOURCE_DIR}/out/jx-soc-haps-arm-cr8/rt-thread)

SET(CMAKE_C_COMPILER "/home/wangshun/gxr/arm-gnu-toolchain-13.2.Rel1-x86_64-arm-none-eabi/bin/arm-none-eabi-gcc")
SET(CMAKE_ASM_COMPILER "/home/wangshun/gxr/arm-gnu-toolchain-13.2.Rel1-x86_64-arm-none-eabi/bin/arm-none-eabi-gcc")
SET(CMAKE_C_FLAGS "-march=armv7-r -mfloat-abi=hard -DNEON -DMPU -ftree-vectorize -ffast-math -mfpu=vfpv3-d16 -O0 -gdwarf-2 -g")
SET(CMAKE_ASM_FLAGS " -march=armv7-r -mfloat-abi=hard -DNEON -DMPU -ftree-vectorize -ffast-math -mfpu=vfpv3-d16 -O0 -c -x assembler-with-cpp -D__ASSEMBLY__ -gdwarf-3 -g")
SET(CMAKE_C_COMPILER_WORKS TRUE)

SET(CMAKE_CXX_COMPILER "/home/wangshun/gxr/arm-gnu-toolchain-13.2.Rel1-x86_64-arm-none-eabi/bin/arm-none-eabi-g++")
SET(CMAKE_CXX_FLAGS "")
SET(CMAKE_CXX_COMPILER_WORKS TRUE)

SET(CMAKE_OBJCOPY "/home/wangshun/gxr/arm-gnu-toolchain-13.2.Rel1-x86_64-arm-none-eabi/bin/arm-none-eabi-objcopy")
SET(CMAKE_SIZE "/home/wangshun/gxr/arm-gnu-toolchain-13.2.Rel1-x86_64-arm-none-eabi/bin/arm-none-eabi-size")

SET(CMAKE_EXE_LINKER_FLAGS " -Wl,--no-warn-rwx-segments,-u,system_vectors,--gc-sections,-Map=rt-thread.map,-cref,-u, -T ${CMAKE_SOURCE_DIR}/board/jx-soc/arm-cr8/link.ld")

SET(CMAKE_CXX_STANDARD 14)
PROJECT(rtthread C CXX ASM)
INCLUDE_DIRECTORIES(
	board/jx-soc/arm-cr8
	3rd-party/rt-thread/components/finsh
	3rd-party/rt-thread/include
	3rd-party/rt-thread/libcpu/arm/cortex-r8
	platform/device/uart/snps-dw
	platform/include/util
	platform/include/device
	platform/include
	platform/device/uart
	out/jx-soc-haps-arm-cr8/rt-thread
)

ADD_DEFINITIONS(
	-DRT_USING_LIBC
	-DRT_USING_NEWLIBC
	-D_POSIX_C_SOURCE=1
	-D__RTTHREAD__
)

SET(PROJECT_SOURCES
	board/jx-soc/arm-cr8/board_rtt.c
	3rd-party/rt-thread/components/finsh/cmd.c
	3rd-party/rt-thread/components/finsh/msh_file.c
	3rd-party/rt-thread/components/finsh/msh_parse.c
	3rd-party/rt-thread/components/finsh/msh.c
	3rd-party/rt-thread/components/finsh/shell.c
	3rd-party/rt-thread/libcpu/arm/cortex-r8/armv7_gcc.S
	3rd-party/rt-thread/libcpu/arm/cortex-r8/context_gcc.S
	3rd-party/rt-thread/libcpu/arm/cortex-r8/core_timer.c
	3rd-party/rt-thread/libcpu/arm/cortex-r8/cp15_gcc.S
	3rd-party/rt-thread/libcpu/arm/cortex-r8/cpu.c
	3rd-party/rt-thread/libcpu/arm/cortex-r8/cpuport_smp.c
	3rd-party/rt-thread/libcpu/arm/cortex-r8/gic_gcc.S
	3rd-party/rt-thread/libcpu/arm/cortex-r8/gic.c
	3rd-party/rt-thread/libcpu/arm/cortex-r8/interrupt.c
	3rd-party/rt-thread/libcpu/arm/cortex-r8/scu_gcc.S
	3rd-party/rt-thread/libcpu/arm/cortex-r8/stack.c
	3rd-party/rt-thread/libcpu/arm/cortex-r8/startup_gcc.S
	3rd-party/rt-thread/libcpu/arm/cortex-r8/trap.c
	3rd-party/rt-thread/libcpu/arm/cortex-r8/vector_gcc.S
	3rd-party/rt-thread/src/clock.c
	3rd-party/rt-thread/src/components.c
	3rd-party/rt-thread/src/cpu.c
	3rd-party/rt-thread/src/idle.c
	3rd-party/rt-thread/src/ipc.c
	3rd-party/rt-thread/src/irq.c
	3rd-party/rt-thread/src/kservice.c
	3rd-party/rt-thread/src/mem.c
	3rd-party/rt-thread/src/memheap.c
	3rd-party/rt-thread/src/mempool.c
	3rd-party/rt-thread/src/object.c
	3rd-party/rt-thread/src/scheduler_mp.c
	3rd-party/rt-thread/src/signal.c
	3rd-party/rt-thread/src/thread.c
	3rd-party/rt-thread/src/timer.c
	platform/device/uart/snps-dw/driver.c
	platform/device/uart/rtt_console_io.c
)

LINK_DIRECTORIES(
)

LINK_LIBRARIES(
	c
	m
)

ADD_EXECUTABLE(${CMAKE_PROJECT_NAME}.elf ${PROJECT_SOURCES})
ADD_CUSTOM_COMMAND(TARGET ${CMAKE_PROJECT_NAME}.elf POST_BUILD 
COMMAND ${CMAKE_OBJCOPY} -O binary ${CMAKE_PROJECT_NAME}.elf ${CMAKE_PROJECT_NAME}.bin COMMAND ${CMAKE_SIZE} ${CMAKE_PROJECT_NAME}.elf)