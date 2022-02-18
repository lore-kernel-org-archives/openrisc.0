From: Al Viro <viro@zeniv.linux.org.uk>
Date: Fri, 18 Feb 2022 01:50:36 +0000
Subject: [OpenRISC] [PATCH v2 00/18] clean up asm/uaccess.h,
 kill set_fs for good
In-Reply-To: <00496df2-f9f2-2547-3ca3-7989e4713d6b@csgroup.eu>
References: <20220216131332.1489939-1-arnd@kernel.org>
 <00496df2-f9f2-2547-3ca3-7989e4713d6b@csgroup.eu>
Message-ID: <Yg77bNZfNhSk0bVQ@zeniv-ca.linux.org.uk>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Feb 17, 2022 at 07:20:11AM +0000, Christophe Leroy wrote:

> And we have also 
> user_access_begin()/user_read_access_begin()/user_write_access_begin() 
> which call access_ok() then do the real work. Could be made generic with 
> call to some arch specific __user_access_begin() and friends after the 
> access_ok() and eventually the might_fault().

Not a good idea, considering the fact that we do not want to invite
uses of "faster" variants...
