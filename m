From: Waiman Long <longman@redhat.com>
Date: Thu, 14 Feb 2019 17:05:27 -0500
Subject: [OpenRISC] [PATCH v4 0/3] locking/rwsem: Rwsem rearchitecture
	part 0
In-Reply-To: <20190214103715.GI32494@hirez.programming.kicks-ass.net>
References: <1550095217-12047-1-git-send-email-longman@redhat.com>
 <20190214103715.GI32494@hirez.programming.kicks-ass.net>
Message-ID: <5c373ba6-419e-c4d5-965f-a566a6182b28@redhat.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

On 02/14/2019 05:37 AM, Peter Zijlstra wrote:
> On Wed, Feb 13, 2019 at 05:00:14PM -0500, Waiman Long wrote:
>> v4:
>>  - Remove rwsem-spinlock.c and make all archs use rwsem-xadd.c.
>>
>> v3:
>>  - Optimize __down_read_trylock() for the uncontended case as suggested
>>    by Linus.
>>
>> v2:
>>  - Add patch 2 to optimize __down_read_trylock() as suggested by PeterZ.
>>  - Update performance test data in patch 1.
>>
>> The goal of this patchset is to remove the architecture specific files
>> for rwsem-xadd to make it easer to add enhancements in the later rwsem
>> patches. It also removes the legacy rwsem-spinlock.c file and make all
>> the architectures use one single implementation of rwsem - rwsem-xadd.c.
>>
>> Waiman Long (3):
>>   locking/rwsem: Remove arch specific rwsem files
>>   locking/rwsem: Remove rwsem-spinlock.c & use rwsem-xadd.c for all
>>     archs
>>   locking/rwsem: Optimize down_read_trylock()
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> with the caveat that I'm happy to exchange patch 3 back to my earlier
> suggestion in case Will expesses concerns wrt the ARM64 performance of
> Linus' suggestion.

I inserted a few lock event counters into the rwsem trylock code:

static inline int __down_read_trylock(struct rw_semaphore *sem)
{
        /*
         * Optimize for the case when the rwsem is not locked at all.
         */
        long tmp = RWSEM_UNLOCKED_VALUE;

        lockevent_inc(rwsem_rtrylock);
        do {
                if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
                                        tmp + RWSEM_ACTIVE_READ_BIAS)) {
                        rwsem_set_reader_owned(sem);
                        return 1;
                }
                lockevent_inc(rwsem_rtrylock_retry);
        } while (tmp >= 0);
        lockevent_inc(rwsem_rtrylock_fail);
        return 0;
}

static inline int __down_write_trylock(struct rw_semaphore *sem)
{
        long tmp;

        lockevent_inc(rwsem_wtrylock);
        tmp = atomic_long_cmpxchg_acquire(&sem->count, RWSEM_UNLOCKED_VALUE,
                      RWSEM_ACTIVE_WRITE_BIAS);
        if (tmp == RWSEM_UNLOCKED_VALUE) {
                rwsem_set_owner(sem);
                return true;
        }
        lockevent_inc(rwsem_wtrylock_fail);
        return false;
}

I booted the new kernel on a 4-socket 56-core 112-thread Broadwell
system. The counter values

1) After bootup:

rwsem_rtrylock=784029
rwsem_rtrylock_fail=59
rwsem_rtrylock_retry=394
rwsem_wtrylock=18284
rwsem_wtrylock_fail=230

2) After parallel kernel build (-j112):

rwsem_rtrylock=338667559
rwsem_rtrylock_fail=18
rwsem_rtrylock_retry=51
rwsem_wtrylock=17016332
rwsem_wtrylock_fail=98058

At least for these two use cases, try-for-ownership as suggested by
Linus is the right choice.

Cheers,
Longman

