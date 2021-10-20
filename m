From: Tom Tromey <tom@tromey.com>
Date: Wed, 20 Oct 2021 11:33:41 -0600
Subject: [OpenRISC] [PATCH 1/5] gdb: or1k: implement gdb server
In-Reply-To: <20210913124800.471680-2-shorne@gmail.com> (Stafford Horne via
 Gdb-patches's message of "Mon, 13 Sep 2021 21:47:56 +0900")
References: <20210913124800.471680-1-shorne@gmail.com>
 <20210913124800.471680-2-shorne@gmail.com>
Message-ID: <87mtn3vbwq.fsf@tromey.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

>>>>> ">" == Stafford Horne via Gdb-patches <gdb-patches@sourceware.org> writes:

>> This patch adds gdbserver support for OpenRISC.  This has been used for
>> debugging the glibc port that in being worked on here:

>>   https://github.com/openrisc/or1k-glibc/tree/or1k-port-2

>> Hence the comment about registers definitions being inline with glibc.

Thanks for the patch.  I had one minor comment.

>> +#define or1k_breakpoint_len 4

>> +bool
>> +or1k_target::low_breakpoint_at (CORE_ADDR where)
>> +{
>> +  unsigned int insn;
>> +
>> +  read_memory (where, (unsigned char *) &insn, 4);

Perhaps this ought to use or1k_breakpoint_len here.

>> +/* Fetch the thread-local storage pointer for libthread_db.  */
>> +
>> +ps_err_e
>> +ps_get_thread_area (struct ps_prochandle *ph,
>> +		    lwpid_t lwpid, int idx, void **base)
>> +{

Not your problem but it seems like a shame that this exact
implementation is repeated several times in gdbserver.

Tom
