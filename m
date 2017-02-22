From: Richard Henderson <rth@twiddle.net>
Date: Thu, 23 Feb 2017 04:31:34 +1100
Subject: [OpenRISC] [PATCH v3 09/25] openrisc: add optimized atomic
 operations
In-Reply-To: <20170222142246.GC2449@lianli.shorne-pla.net>
References: <cover.1487702890.git.shorne@gmail.com>
 <1479fc4a4a18712003849341affe74b2a0da609a.1487702890.git.shorne@gmail.com>
 <20170222112737.GM6515@twins.programming.kicks-ass.net>
 <20170222142246.GC2449@lianli.shorne-pla.net>
Message-ID: <c775b4d1-fa98-c1b2-d212-1441343b62d4@twiddle.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 02/23/2017 01:22 AM, Stafford Horne wrote:
>> static inline int __atomic_add_unless(atomic_t *v, int a, int u)
>> {
>> 	int old, tmp;
>>
>> 	__asm__ __volatile__(
>> 		"1:     l.lwa %0, 0(%2)         \n"
>> 		"       l.sfeq %0, %4           \n"
>> 		"       l.bf 2f                 \n"
>> 		"        l.nop                  \n"
>> 		"	l.add %1, %0, %3	\n"

You can move this add into the delay slot and drop the preceding nop.


r~
