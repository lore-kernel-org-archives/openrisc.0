From: Rieger, David <david.rieger@student.kit.edu>
Date: Mon, 16 Jan 2017 11:24:50 +0000
Subject: [OpenRISC] Clang does not understand .word directive in crt0.S in
	newlib source
Message-ID: <bc71a06a3bf94b40b2adcdc8f816199f@kit-msx-25.kit.edu>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello everyone

I am trying to compile newlib using clang/LLVM 3.8.1 with the or1k target. However, compilation fails on newlib-source/libgloss/or1k/crt0.S with clang complaining it does not know the ".word" assembler directive:

../newlib-source/libgloss/or1k/crt0.S:83:19: error: unknown directive
_or1k_stack_size: .word 8192
                  ^
../newlib-source/libgloss/or1k/crt0.S:84:29: error: unknown directive
_or1k_exception_stack_size: .word 8192

Any help in how I can fix this so clang compiles the file would be greatly appreciated.

Thanks
David
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20170116/d656ec45/attachment.html>
