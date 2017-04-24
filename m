From: no-reply@patchew.org <no-reply@patchew.org>
Date: Sun, 23 Apr 2017 17:09:59 -0700 (PDT)
Subject: [OpenRISC] [Qemu-devel] [PATCH v2 0/9] Openrisc misc features /
	fixes
In-Reply-To: <cover.1492986468.git.shorne@gmail.com>
Message-ID: <149299259912.69.3083061025771244064@c05f1edc8ed1>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi,

This series seems to have some coding style problems. See output below for
more information:

Message-id: cover.1492986468.git.shorne at gmail.com
Subject: [Qemu-devel] [PATCH v2 0/9] Openrisc misc features / fixes
Type: series

=== TEST SCRIPT BEGIN ===
#!/bin/bash

BASE=base
n=1
total=$(git log --oneline $BASE.. | wc -l)
failed=0

# Useful git options
git config --local diff.renamelimit 0
git config --local diff.renames True

commits="$(git log --format=%H --reverse $BASE..)"
for c in $commits; do
    echo "Checking PATCH $n/$total: $(git log -n 1 --format=%s $c)..."
    if ! git show $c --format=email | ./scripts/checkpatch.pl --mailback -; then
        failed=1
        echo
    fi
    n=$((n+1))
done

exit $failed
=== TEST SCRIPT END ===

Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
Switched to a new branch 'test'
e25195d target/openrisc: Remove duplicate features property
7ed50bd target/openrisc: Implement full vmstate serialization
49d0127 migration: Add VMSTATE_STRUCT_2DARRAY()
27c47a9 target/openrisc: implement shadow registers
7cf6151 migration: Add VMSTATE_UINTTL_2DARRAY()
649863f target/openrisc: add numcores and coreid support
dab96ab target/openrisc: Fixes for memory debugging
9fe0bd9 target/openrisc: Implement EPH bit
42314a9 target/openrisc: Implement EVBAR register

=== OUTPUT BEGIN ===
Checking PATCH 1/9: target/openrisc: Implement EVBAR register...
Checking PATCH 2/9: target/openrisc: Implement EPH bit...
Checking PATCH 3/9: target/openrisc: Fixes for memory debugging...
WARNING: line over 80 characters
#45: FILE: target/openrisc/mmu.c:232:
+        miss = cpu_openrisc_get_phys_addr(cpu, &phys_addr, &prot, addr, MMU_INST_FETCH);

total: 0 errors, 1 warnings, 38 lines checked

Your patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.
Checking PATCH 4/9: target/openrisc: add numcores and coreid support...
Checking PATCH 5/9: migration: Add VMSTATE_UINTTL_2DARRAY()...
Checking PATCH 6/9: target/openrisc: implement shadow registers...
WARNING: line over 80 characters
#135: FILE: linux-user/signal.c:4492:
+    __put_user(sas_ss_flags(cpu_get_gpr(env, 1)), &frame->uc.tuc_stack.ss_flags);

total: 0 errors, 1 warnings, 230 lines checked

Your patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.
Checking PATCH 7/9: migration: Add VMSTATE_STRUCT_2DARRAY()...
ERROR: line over 90 characters
#20: FILE: include/migration/vmstate.h:503:
+#define VMSTATE_STRUCT_2DARRAY_TEST(_field, _state, _n1, _n2, _test, _version, _vmsd, _type) { \

ERROR: spaces required around that '|' (ctx:VxV)
#27: FILE: include/migration/vmstate.h:510:
+    .flags        = VMS_STRUCT|VMS_ARRAY,                                   \
                               ^

WARNING: line over 80 characters
#38: FILE: include/migration/vmstate.h:761:
+#define VMSTATE_STRUCT_2DARRAY(_field, _state, _n1, _n2, _version, _vmsd, _type) \

total: 2 errors, 1 warnings, 27 lines checked

Your patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.

Checking PATCH 8/9: target/openrisc: Implement full vmstate serialization...
Checking PATCH 9/9: target/openrisc: Remove duplicate features property...
=== OUTPUT END ===

Test command exited with code: 1


---
Email generated automatically by Patchew [http://patchew.org/].
Please send your feedback to patchew-devel at freelists.org
