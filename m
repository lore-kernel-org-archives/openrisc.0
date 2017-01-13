From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Date: Fri, 13 Jan 2017 17:01:01 +0100
Subject: [OpenRISC] [PATCH v3 1/8] arm: put types.h in uapi
In-Reply-To: <25063.1484321803@warthog.procyon.org.uk>
References: <1484304406-10820-2-git-send-email-nicolas.dichtel@6wind.com>
 <3131144.4Ej3KFWRbz@wuerfel>
 <1484304406-10820-1-git-send-email-nicolas.dichtel@6wind.com>
 <25063.1484321803@warthog.procyon.org.uk>
Message-ID: <4633e475-47f2-5627-81a9-a1747dfddbc0@6wind.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

Please, do not remove the email subject when you reply. I restore it to ease the
thread follow-up.

Le 13/01/2017 à 16:36, David Howells a écrit :
> Nicolas Dichtel <nicolas.dichtel@6wind.com> wrote:
> 
>> This header file is exported, thus move it to uapi.
> 
> Exported how?
It is listed in include/uapi/asm-generic/Kbuild.asm, which is included by
arch/arm/include/uapi/asm/Kbuild.

You can also have a look at patch #5 to see why it was exported even if it was
not in an uapi directory.

Regards,
Nicolas
