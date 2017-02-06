From: Richard Henderson <rth@twiddle.net>
Date: Mon, 6 Feb 2017 12:44:56 -0800
Subject: [OpenRISC] [Qemu-devel] [PATCH] target-openrisc: Fix exception
 handling status registers
In-Reply-To: <20170202143455.GB32144@lianli.shorne-pla.net>
References: <20170120163918.GD7836@lianli.shorne-pla.net>
 <d27b7c60-a9fe-e92e-a937-d2d13b78f290@twiddle.net>
 <20170124102625.GF7836@lianli.shorne-pla.net>
 <01f7a18d-f4f5-18f3-0932-b32c06ad0b0c@twiddle.net>
 <20170125123430.GG7836@lianli.shorne-pla.net>
 <39f927aa-26fe-0e43-7c6b-efe1b70bc5fa@twiddle.net>
 <20170126131229.GB16014@lianli.shorne-pla.net>
 <ddb9c656-aa3e-5d90-c8fc-0058af5b603b@twiddle.net>
 <20170201100423.GE21641@lianli.shorne-pla.net>
 <c840eff0-2be7-07d7-eae9-4cded569d146@twiddle.net>
 <20170202143455.GB32144@lianli.shorne-pla.net>
Message-ID: <e9f58f51-4cca-6136-d392-91c805d5631d@twiddle.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

[ qemu lists trimed ]
On 02/02/2017 06:34 AM, Stafford Horne wrote:
> What issue are you having compiling gdb?


 
/home/rth/work/gcc/bld-or/sim/or1k/../../../comb-or/sim/or1k/sem32-switch.c:589: 
undefined reference to `or1k32bf_exception'
 
/home/rth/work/gcc/bld-or/sim/or1k/../../../comb-or/sim/or1k/sem32-switch.c:574: 
undefined reference to `or1k32bf_exception'
 
/home/rth/work/gcc/bld-or/sim/or1k/../../../comb-or/sim/or1k/sem32-switch.c:649: 
undefined reference to `or1k32bf_rfe'
 
/home/rth/work/gcc/bld-or/sim/or1k/../../../comb-or/sim/or1k/sem32-switch.c:730: 
undefined reference to `or1k32bf_mfspr'
 
/home/rth/work/gcc/bld-or/sim/or1k/../../../comb-or/sim/or1k/sem32-switch.c:748: 
undefined reference to `or1k32bf_mtspr'
 
/home/rth/work/gcc/bld-or/sim/or1k/../../../comb-or/sim/or1k/sem32-switch.c:1717: 
undefined reference to `or1k32bf_exception'
 
/home/rth/work/gcc/bld-or/sim/or1k/../../../comb-or/sim/or1k/sem32-switch.c:1681: 
undefined reference to `or1k32bf_exception'
 
/home/rth/work/gcc/bld-or/sim/or1k/../../../comb-or/sim/or1k/sem32-switch.c:1643: 
undefined reference to `or1k32bf_exception'
 
/home/rth/work/gcc/bld-or/sim/or1k/../../../comb-or/sim/or1k/sem32-switch.c:1511: 
undefined reference to `or1k32bf_exception'
 
/home/rth/work/gcc/bld-or/sim/or1k/../../../comb-or/sim/or1k/sem32-switch.c:1463: 
undefined reference to `or1k32bf_exception'
 
../sim/or1k/libsim.a(mloop32.o):/home/rth/work/gcc/bld-or/sim/or1k/../../../comb-or/sim/or1k/sem32-switch.c:1416: 
more undefined references to `or1k32bf_exception' follow
  ../sim/or1k/libsim.a(sem32.o): In function `or1k32bf_sem_l_mtspr':
  /home/rth/work/gcc/bld-or/sim/or1k/../../../comb-or/sim/or1k/sem32.c:635: 
undefined reference to `or1k32bf_mtspr'
  ../sim/or1k/libsim.a(sem32.o): In function `or1k32bf_sem_l_mfspr':
  /home/rth/work/gcc/bld-or/sim/or1k/../../../comb-or/sim/or1k/sem32.c:615: 
undefined reference to `or1k32bf_mfspr'
  ../sim/or1k/libsim.a(sem32.o): In function `or1k32bf_sem_l_rfe':
  /home/rth/work/gcc/bld-or/sim/or1k/../../../comb-or/sim/or1k/sem32.c:526: 
undefined reference to `or1k32bf_rfe'
  collect2: error: ld returned 1 exit status



r~
