From: Florian Weimer <fweimer@redhat.com>
Date: Mon, 24 Jan 2022 14:23:07 +0100
Subject: [OpenRISC] [PATCH v5 00/13] Glibc OpenRISC port
In-Reply-To: <20220104031414.2416928-1-shorne@gmail.com> (Stafford Horne's
 message of "Tue, 4 Jan 2022 12:14:01 +0900")
References: <20220104031414.2416928-1-shorne@gmail.com>
Message-ID: <87tudt2rpg.fsf@oldenburg.str.redhat.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

* Stafford Horne:

> This is the OpenRISC port for glibc that I have been working on.

The port does not define PI_STATIC_AND_HIDDEN.  Is this really
necessary, or just an oversight due to the way the port was constructed
(presumably with MIPS as the template)?

PI_STATIC_AND_HIDDEN means that references to static functions and data
and symbols with hidden visibility do not need any run-time relocations
after the final link, with the build flags used by glibc.

Thanks,
Florian

