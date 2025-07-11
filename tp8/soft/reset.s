#################################################################################
#	File : reset.s
#	Author : Alain Greiner
#	Date : 25/12/2011
#################################################################################
#       This is an improved boot code for a multi-processor architecture
#       containing from 1 to 4 processors.
#	Depending on the proc_id, each processor
#       - initializes the interrupt vector.
#       - initializes the ICU MASK registers.
#       - initializes the TIMER .
#       - initializes the Status Register.
#       - initializes the stack pointer.
#       All processors jump to the same user code.
#################################################################################
		
	.section .reset,"ax",@progbits

	.extern	seg_stack_base
	.extern	seg_data_base
	.extern	seg_timer_base
	.extern	seg_icu_base

	.func	reset
	.type   reset, %function

reset:
		.set noreorder

# get the processor id and branch
        mfc0	$27,	$15,	1		# get the proc_id
        andi	$27,	$27,	0x3		# no more than 4 processors
        li	$26,	0
        beq	$27,	$26,	proc0
        li	$26,	1
        beq	$27,	$26,	proc1
        li	$26,	2
        beq	$27,	$26,	proc2
        li	$26,	3
        beq	$27,	$26,	proc3
        nop

proc0:
	# initialises interrupt vector entries for PROC[0]
	la	$26,	_interrupt_vector
	la	$27,	_isr_dma
	sw	$27,	0($26)			# _interrupt_vector[0] <= _isr_dma
	la	$27,	_isr_ioc
	sw	$27,	4($26)			# _interrupt_vector[1] <= _isr_ioc
	la	$27,	_isr_timer
	sw	$27,	8($26)			# _interrupt_vector[2] <= _isr_timer
	la	$27,	_isr_tty_get
	sw	$27,	12($26)			# _interrupt_vector[3] <= _isr_tty_get

	#initializes the ICU[0] MASK register
	la	$26,	seg_icu_base
	addiu	$26,	$26,	0		# ICU[0]
	li  	$27,	0b1111		# IRQ_DMA, IRQ_IOC, IRQ_TIM[0] & IRQ_TTY[0]
	sw	$27,	8($26)

	# initializes stack pointer for PROC[0]
	la	$29,	seg_stack_base
	li	$27,	0x10000		# stack size = 64K
	addu	$29,	$29,	$27    		# $29 <= seg_stack_base + 64K

	# initializes SR register for PROC[0]
	li	$26,	0x0000FF13	
	mtc0	$26,	$12			# SR <= 0x0000FF13

	# jump to main in user mode: main[0]
	la	$26,	seg_data_base
	lw	$26,	0($26)			# $26 <= main[0]
	mtc0	$26,	$14			# write it in EPC register
	eret

proc1:
	# initialises interrupt vector entries for PROC[1]
	la	$26,	_interrupt_vector
	la	$27,	_isr_timer
	sw	$27,	16($26)			# _interrupt_vector[4] <= _isr_timer
	la	$27,	_isr_tty_get
	sw	$27,	20($26)			# _interrupt_vector[5] <= _isr_tty_get

	#initializes the ICU[1] MASK register
	la	$26,	seg_icu_base
	addiu	$26,	$26,	32		# ICU[1]
	li  	$27,	0b110000		# IRQ_TIM[1], IRQ_TTY[1]
	sw	$27,	8($26)

	# initializes stack pointer for PROC[1]
	la	$29,	seg_stack_base
	li	$27,	0x20000		# stack size = 64K
	addu	$29,	$29,	$27    		# $29 <= seg_stack_base + 128K

	# initializes SR register for PROC[1]
	li	$26,	0x0000FF13	
	mtc0	$26,	$12			# SR <= 0x0000FF13

	# jump to main in user mode: main[1]
	la	$26,	seg_data_base
	lw	$26,	0($26)			# $26 <= main[1] 
	mtc0	$26,	$14			# write it in EPC register
	eret

proc2:
	# initialises interrupt vector entries for PROC[2]
	la	$26,	_interrupt_vector
	la	$27,	_isr_timer
	sw	$27,	24($26)			# _interrupt_vector[6] <= _isr_timer
	la	$27,	_isr_tty_get
	sw	$27,	28($26)			# _interrupt_vector[7] <= _isr_tty_get

	#initializes the ICU[2] MASK register
	la	$26,	seg_icu_base
	addiu	$26,	$26,	64		# ICU[2]
	li  	$27,	0b11000000		# IRQ_TIM[2], IRQ_TTY[2]
	sw	$27,	8($26)

	# initializes stack pointer for PROC[2]
	la	$29,	seg_stack_base
	li	$27,	0x30000		# stack size = 64K
	addu	$29,	$29,	$27    		# $29 <= seg_stack_base + 192K

	# initializes SR register for PROC[2]
	li	$26,	0x0000FF13	
	mtc0	$26,	$12			# SR <= 0x0000FF13

	# jump to main in user mode: main[2]
	la	$26,	seg_data_base
	lw	$26,	0($26)			# $26 <= main[2] 
	mtc0	$26,	$14			# write it in EPC register
	eret

proc3:
	# initialises interrupt vector entries for PROC[3]
	la	$26,	_interrupt_vector
	la	$27,	_isr_timer
	sw	$27,	32($26)			# _interrupt_vector[8] <= _isr_timer
	la	$27,	_isr_tty_get
	sw	$27,	36($26)			# _interrupt_vector[9] <= _isr_tty_get

	#initializes the ICU[3] MASK register
	la	$26,	seg_icu_base
	addiu	$26,	$26,	96		# ICU[3]
	li  	$27,	0b1100000000		# IRQ_TIM[3], IRQ_TTY[3]
	sw	$27,	8($26)

	# initializes stack pointer for PROC[3]
	la	$29,	seg_stack_base
	li	$27,	0x40000		# stack size = 64K
	addu	$29,	$29,	$27    		# $29 <= seg_stack_base + 256K

	# initializes SR register for PROC[3]
	li	$26,	0x0000FF13	
	mtc0	$26,	$12			# SR <= 0x0000FF13

	# jump to main in user mode: main[3]
	la	$26,	seg_data_base
	lw	$26,	0($26)			# $26 <= main[3] 
	mtc0	$26,	$14			# write it in EPC register
	eret

	.set reorder
	.endfunc
	.size	reset, .-reset

