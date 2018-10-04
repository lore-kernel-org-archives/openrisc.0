From: Stafford Horne <shorne@gmail.com>
Date: Thu, 4 Oct 2018 11:58:46 +0900
Subject: [OpenRISC] [PATCH v2 0/5] OpenRISC binutils updates and new
	relocs
In-Reply-To: <70baf6b8-d26c-f518-78e5-48a6ad47ce54@redhat.com>
References: <20181001071001.20446-1-shorne@gmail.com>
 <70baf6b8-d26c-f518-78e5-48a6ad47ce54@redhat.com>
Message-ID: <20181004025846.GD32353@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Oct 02, 2018 at 04:38:39PM +0100, Nick Clifton wrote:
> Hi Stafford,
> 
>   I just applied your v2 patch series and found one new regression:
> 
> Checking Binutils in: or1k-elf ... LD: 1  done
>  LD REGRESSION: ld-scripts/pr22267    
> 
>   Would you mind taking a quick look please ?

Hello,

This is just a note for Richard.  Please let me know if my fix has any problems.

This issue was with the new overflow added which was thinking that OpenRISC was
a 64-bit system.  I replaced it with the generic stuff which uses the bit width
of the target system not host system (i.e. bfd_vma) for overflow calculations.

Change below...

-Stafford

diff --git a/bfd/elf32-or1k.c b/bfd/elf32-or1k.c
index 3e5759d63f..a2b0ff147f 100644
--- a/bfd/elf32-or1k.c
+++ b/bfd/elf32-or1k.c
@@ -1067,7 +1067,6 @@ or1k_final_link_relocate (reloc_howto_type *howto, bfd *input_bfd,
 {
   bfd_reloc_status_type status = bfd_reloc_ok;
   int size = bfd_get_reloc_size (howto);
-  unsigned bitsize, bits;
   bfd_vma x, place;
 
   /* Sanity check the address.  */
@@ -1118,38 +1117,11 @@ or1k_final_link_relocate (reloc_howto_type *howto, bfd *input_bfd,
       break;
     }
 
-  bitsize = howto->bitsize;
-  bits = bitsize + howto->rightshift;
-  switch (howto->complain_on_overflow)
-    {
-    case complain_overflow_dont:
-      break;
-    case complain_overflow_signed:
-      if (bits < sizeof (bfd_vma) * 8)
-	{
-	  bfd_signed_vma lim = (bfd_vma)1 << bits;
-	  bfd_signed_vma svalue = value;
-
-	  if (svalue < -lim || svalue >= lim)
-	    status = bfd_reloc_overflow;
-	}
-      break;
-    case complain_overflow_unsigned:
-      if (bits < sizeof (bfd_vma) * 8)
-	{
-	  bfd_vma lim = (bfd_vma)1 << bits;
-	  if (value >= lim)
-	    status = bfd_reloc_overflow;
-	}
-      break;
-    case complain_overflow_bitfield:
-    default:
-      _bfd_error_handler
-	(_("%pB: Unimplemented complain on overflow in howto structure: %d"),
-	 input_bfd, (int) howto->complain_on_overflow);
-      abort ();
-    }
-
+  status = bfd_check_overflow (howto->complain_on_overflow,
+			       howto->bitsize,
+			       howto->rightshift,
+			       bfd_arch_bits_per_address (input_bfd),
+			       value);
   value >>= howto->rightshift;
 
   /* If we're overwriting the entire destination,
@@ -1206,7 +1178,6 @@ or1k_final_link_relocate (reloc_howto_type *howto, bfd *input_bfd,
 	 input_bfd, size);
       abort ();
     }
-
   return status;
 }
 
-- 
2.17.1

