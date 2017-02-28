From: Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 28 Feb 2017 21:21:02 +1100
Subject: [OpenRISC] [PATCH] kbuild: avoid unrecognized option error for
	external DTC
In-Reply-To: <1488204416.2819.9.camel@decadent.org.uk>
References: <1488174052-2530-1-git-send-email-yamada.masahiro@socionext.com>
 <1488204416.2819.9.camel@decadent.org.uk>
Message-ID: <87tw7epqep.fsf@concordia.ellerman.id.au>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

Ben Hutchings <ben@decadent.org.uk> writes:

> [ Unknown signature status ]
> On Mon, 2017-02-27 at 14:40 +0900, Masahiro Yamada wrote:
>> Since commit 6b22b3d1614a ("kbuild: Allow using host dtc instead of
>> kernel's copy"), it is possible to use an external dtc.  In this
>> case, we do not know which options are supported on it.
>> 
>> Commit bc553986a2f7 ("dtc: turn off dtc unit address warnings by
>> default") gives -Wno-unit_address_vs_reg, but this options is only
>> recognized by v1.4.2 or later.
>> 
>> If an older version is specified, the build fails:
>
> But the option to use an external dtc was intended to allow testing of
> newer versions.  If there's no reason to use this option to run an
> older version, why bother trying to support that?

+1

That's a lot of added complexity, when the answer could just be "use the
kernel dtc".

cheers
