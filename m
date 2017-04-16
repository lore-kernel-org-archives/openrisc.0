From: no-reply@patchew.org <no-reply@patchew.org>
Date: Sun, 16 Apr 2017 16:33:19 -0700 (PDT)
Subject: [OpenRISC] [Qemu-devel] [PATCH 0/7] Openrisc misc features /
	fixes
In-Reply-To: <cover.1492384862.git.shorne@gmail.com>
Message-ID: <149238559853.10512.7357340442722775269@6c512846dbc7>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi,

This series seems to have some coding style problems. See output below for
more information:

Type: series
Subject: [Qemu-devel] [PATCH 0/7] Openrisc misc features / fixes
Message-id: cover.1492384862.git.shorne at gmail.com

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
From https://github.com/patchew-project/qemu
 * [new tag]         patchew/cover.1492384862.git.shorne at gmail.com -> patchew/cover.1492384862.git.shorne at gmail.com
Switched to a new branch 'test'
10e376c target/openrisc: Implement full vmstate serialization
1c965d5 migration: Add VMSTATE_STRUCT_2DARRAY()
66d129f migration: Add VMSTATE_UINTTL_2DARRAY()
da6e29e target/openrisc: implement shadow registers
edd6b74 target/openrisc: add numcores and coreid support
16702b5 target/openrisc: add shutdown logic
c97a00e target/openrisc: Fixes for memory debugging

=== OUTPUT BEGIN ===
Checking PATCH 1/7: target/openrisc: Fixes for memory debugging...
WARNING: line over 80 characters
#44: FILE: target/openrisc/mmu.c:232:
+        miss = cpu_openrisc_get_phys_addr(cpu, &phys_addr, &prot, addr, MMU_INST_FETCH);

total: 0 errors, 1 warnings, 38 lines checked

Your patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.
Checking PATCH 2/7: target/openrisc: add shutdown logic...
Checking PATCH 3/7: target/openrisc: add numcores and coreid support...
Checking PATCH 4/7: target/openrisc: implement shadow registers...
ERROR: "foo * bar" should be "foo *bar"
#67: FILE: target/openrisc/cpu.h:273:
+    target_ulong * gpr;       /* General registers (backed by shadow) */

total: 1 errors, 0 warnings, 98 lines checked

Your patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.

Checking PATCH 5/7: migration: Add VMSTATE_UINTTL_2DARRAY()...
Checking PATCH 6/7: migration: Add VMSTATE_STRUCT_2DARRAY()...
ERROR: line over 90 characters
#20: FILE: include/migration/vmstate.h:502:
+#define VMSTATE_STRUCT_2DARRAY_TEST(_field, _state, _n1, _n2, _test, _version, _vmsd, _type) { \

ERROR: spaces required around that '|' (ctx:VxV)
#27: FILE: include/migration/vmstate.h:509:
+    .flags        = VMS_STRUCT|VMS_ARRAY,                                   \
                               ^

WARNING: line over 80 characters
#38: FILE: include/migration/vmstate.h:760:
+#define VMSTATE_STRUCT_2DARRAY(_field, _state, _n1, _n2, _version, _vmsd, _type) \

total: 2 errors, 1 warnings, 27 lines checked

Your patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.

Checking PATCH 7/7: target/openrisc: Implement full vmstate serialization...
=== OUTPUT END ===

Test command exited with code: 1


---
Email generated automatically by Patchew [http://patchew.org/].
Please send your feedback to patchew-devel at freelists.org
