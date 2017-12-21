From: Simon Marchi <simon.marchi@polymtl.ca>
Date: Wed, 20 Dec 2017 21:58:45 -0500
Subject: [OpenRISC] [PATCH v3 1/4] reggroups: Add test and docs for
 `info reg $reggroup` feature
In-Reply-To: <20171219142257.13402-2-shorne@gmail.com>
References: <20171219142257.13402-1-shorne@gmail.com>
 <20171219142257.13402-2-shorne@gmail.com>
Message-ID: <00b5d74739aced5252fd0a035397b11f@polymtl.ca>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 2017-12-19 09:22, Stafford Horne wrote:
> Until now this feature has existed but was not documented.  Adding docs
> and tests.
> 
> gdb/ChangeLog:
> 
> 2017-06-06  Stafford Horne  <shorne@gmail.com>
> 
> 	* infcmd.c (_initialize_infcmd): Add help for info reg $reggroup
> 	feature.
> 
> gdb/doc/ChangeLog:
> 
> 2017-06-06  Stafford Horne  <shorne@gmail.com>
> 
> 	* gdb.texinfo (Registers): Document info reg $reggroup feature.
> 
> gdb/testsuite/ChangeLog:
> 
> 2017-06-06  Stafford Horne  <shorne@gmail.com>
> 
> 	* gdb.base/reggroups.c: New file.
> 	* gdb.base/reggroups.exp: New file.
> ---
>  gdb/doc/gdb.texinfo                  |  5 +++
>  gdb/infcmd.c                         |  8 +++--
>  gdb/testsuite/gdb.base/reggroups.c   |  5 +++
>  gdb/testsuite/gdb.base/reggroups.exp | 63 
> ++++++++++++++++++++++++++++++++++++
>  4 files changed, 79 insertions(+), 2 deletions(-)
>  create mode 100644 gdb/testsuite/gdb.base/reggroups.c
>  create mode 100644 gdb/testsuite/gdb.base/reggroups.exp
> 
> diff --git a/gdb/doc/gdb.texinfo b/gdb/doc/gdb.texinfo
> index 60ed80c363..e169260e7e 100644
> --- a/gdb/doc/gdb.texinfo
> +++ b/gdb/doc/gdb.texinfo
> @@ -11023,6 +11023,11 @@ and vector registers (in the selected stack 
> frame).
>  Print the names and values of all registers, including floating-point
>  and vector registers (in the selected stack frame).
> 
> + at item info registers @var{reggroup} @dots{}
> +Print the name and value of the registers in each of the specified
> + at var{reggroup}.  The @var{reggoup} can be any of those returned by
> + at code{maint print reggroups}.
> +
>  @item info registers @var{regname} @dots{}
>  Print the @dfn{relativized} value of each specified register 
> @var{regname}.
>  As discussed in detail below, register values are normally relative to
> diff --git a/gdb/infcmd.c b/gdb/infcmd.c
> index 8bde28eab6..6e449d4a0e 100644
> --- a/gdb/infcmd.c
> +++ b/gdb/infcmd.c
> @@ -3460,13 +3460,17 @@ interrupt all running threads in non-stop
> mode, use the -a option."));
> 
>    c = add_info ("registers", info_registers_command, _("\
>  List of integer registers and their contents, for selected stack 
> frame.\n\
> -Register name as argument means describe only that register."));
> +Register name as argument means describe only that register.\n\
> +Register group name as argument means describe the registers in the\n\
> +named register group."));
>    add_info_alias ("r", "registers", 1);
>    set_cmd_completer (c, reg_or_group_completer);
> 
>    c = add_info ("all-registers", info_all_registers_command, _("\
>  List of all registers and their contents, for selected stack frame.\n\
> -Register name as argument means describe only that register."));
> +Register name as argument means describe only that register.\n\
> +Register group name as argument means describe the registers in the\n\
> +named register group."));
>    set_cmd_completer (c, reg_or_group_completer);
> 
>    add_info ("program", info_program_command,
> diff --git a/gdb/testsuite/gdb.base/reggroups.c
> b/gdb/testsuite/gdb.base/reggroups.c
> new file mode 100644
> index 0000000000..8e8f518aae
> --- /dev/null
> +++ b/gdb/testsuite/gdb.base/reggroups.c
> @@ -0,0 +1,5 @@
> +int
> +main()
> +{
> +  return 0;
> +}
> diff --git a/gdb/testsuite/gdb.base/reggroups.exp
> b/gdb/testsuite/gdb.base/reggroups.exp
> new file mode 100644
> index 0000000000..c10f02567d
> --- /dev/null
> +++ b/gdb/testsuite/gdb.base/reggroups.exp
> @@ -0,0 +1,63 @@
> +# This testcase is part of GDB, the GNU debugger.
> +
> +# Copyright 2017 Free Software Foundation, Inc.
> +
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 3 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see 
> <http://www.gnu.org/licenses/>.
> +
> +# Test listing reggroups and the registers in each group.
> +
> +standard_testfile
> +
> +if {[prepare_for_testing "failed to prepare" $testfile $srcfile 
> debug]} {
> +    return -1
> +}
> +
> +if ![runto_main] then {
> +    fail "can't run to main"
> +    return 0
> +}
> +
> +proc fetch_reggroups {test} {
> +    global gdb_prompt
> +    global expect_out
> +
> +    set reggroups {}
> +    gdb_test_multiple "maint print reggroups" "get reggroups" {
> +	-re "maint print reggroups\r\n" {
> +	    exp_continue
> +	}
> +	-re "^ Group\[ \t\]+Type\[ \t\]+\r\n" {
> +	    exp_continue
> +	}
> +	-re "^ (\[0-9a-zA-Z\-\]+)\[ \t\]+(user|internal)\[ \t\]+\r\n" {
> +	    lappend reggroups $expect_out(1,string)
> +	    exp_continue
> +	}
> +	-re ".*$gdb_prompt $" {

The .* should not be necessary here.

> +	    if { [llength $reggroups] != 0 } {
> +		pass $test
> +	    } else {
> +		fail "$test - didn't fetch any reggroups"
> +	    }
> +	}
> +    }
> +
> +    return $reggroups
> +}
> +
> +set reggroups [fetch_reggroups "fetch reggroups"]
> +
> +foreach reggroup $reggroups {
> +    gdb_test "info reg $reggroup" ".*" "info reg $reggroup"
> +}

This doesn't really test anything.  If you change the line to

   gdb_test "info reg hello$reggroup" ".*" "info reg $reggroup"

to fake that the command doesn't work, the test still passes.  So if 
something breaks the feature of "info registers" handling reg groups, 
the test won't catch it.  But I understand the problem, the output is 
not really predictable.  I thought about matching at least one $hex 
number, but it's not even guaranteed (some groups like mmx output 
nothing).

What we could do (I'm open to better suggestions) is at least validate 
that it doesn't output "Invalid register", which is the message given 
when passing a register that doesn't exist.  But then, if that message 
changes one day for some reason, the test will become moot again 
(because GDB will output something else than "Invalid register" if the 
functionality breaks, but the test won't catch it).  So in addition, we 
could also validate that "info registers a_non_existent_register" does 
output "Invalid register".  This way, if some GDB developers of the 
future change the message, the test will fail, they will go look at your 
test file, read the comment that you will have left, and update the test 
accordingly.

Simon
