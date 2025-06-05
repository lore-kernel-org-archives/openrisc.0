Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BFD20B22;
	Thu,  5 Jun 2025 09:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749116061; cv=fail; b=c/tEEicziNclAXObhoOPw0WRJuRJEYVaYMuXNN5YzI+pQI0CXCMA0W3wZJ11RaiKgw1fj8BQsXYbdXeuGyhxze0aaLgXnZGnFSfZnHVnGOdiDGQxqDwAaC2wWjWOKxGwrwfhOHUhqyFFmzRe2Jwkg8j68ys4+SYTPIdsBkuN0Fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749116061; c=relaxed/simple;
	bh=bfwLtYP/UMCPtfHsM486xPzcXFtbU0HAsr2Mn58KtKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rz4tPXtnR59KQnai7mUlT896Sunptz/B243VYef38NcIHQ9qoU1Se5488362MdoMIol+dj22qF9VlA5frigfp7HhHGKCm7unalB8UN9J8AdMEPTc1Cry10vjiKar9WBMSGJ3bA14WOySRbhsCRYGRUuOjV+A9Pgv8E0s1n/DYHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PHK8mhuR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Soecacw4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PHK8mhuR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Soecacw4"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5554vuE0003806;
	Thu, 5 Jun 2025 09:33:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ekUYK4n/RzFdwDF2VM
	8EdRId9GGkXny82ctSJAKWJAs=; b=PHK8mhuRaJ2Hrkften7eBnzFWp9kI9a+Ht
	Z8NFs7RV3dPkZ4bdKIHPpCV1UTYaedS5/6RpZQxYVJOFREajoDPZ3e5gzzFgZWpx
	xooHH2Z3lCvt2uv58Y08K9SoF2gBtMZ6+dDmAFPUQoIwjArxAy5OXTcQ5XYx8Nie
	UpFcdf4DiOEBG7CbTNDORpQ8DD3kWQTN9rikXw7noqaXPQRW3SROxQHOWekF5UcN
	j858ZBOF26BN2wD7m+qVzOGglyp4Ri+7KwztnBeuOp3OIMyGNKYsvDhj3EvUQIsd
	pT0BYBl0/lOEbOWLXzxHzJLf3cZnrcZzkfgVliwY94+Rwn3Jae0Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8dwuhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Jun 2025 09:33:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5557kGYs016123;
	Thu, 5 Jun 2025 09:33:20 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7buysu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Jun 2025 09:33:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XgpaZyZJRVSGpLyUVNtAkz01G13RlJqbSZJZy82+4t73sSbmoydvWql/WEKmCRnXg8QvVW4n+7mD1JP3YLZS6kjo9eWqUh4HgRpUERoRm5/xRzUdtNaivYnMN83eRoZNghYFRJftoeCEb1vFaH6mt6+4FcTbl7iiCmbiEAaUc7TnyHxxU8HIyQBsmaMufGU7P34qOjfHEzrcb5FPbEN4AJ1at4FSeH4rvmtga+6CbP0dR67tn9TXZScuI4VrZzLjAXMRRTx4m1V3Peyg/V/HHb7hTxDOzUXVxkKBzeOb5fCvb2nu60rUe9Q0u5BBNeyYrNsm6L2A/nIS5wufjseanw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekUYK4n/RzFdwDF2VM8EdRId9GGkXny82ctSJAKWJAs=;
 b=LRXXNF5u/rJMxD/JyFwSJPXkiy4zAAYUn4UiNi6+UPh1+I8nzLs814mZb0JAGfbHG7uVxlmIdI3v4OU8sQstcYYEaDWmzvQh6DsxuU8bnoVoRRkaKMFcBVy/a6FoQmHXbpNGWnOdHjQrRD9TLS2T1FFcUq4h5vPZea6/6ojybTiX9pB8fQrEdb/ltfk1f2aH3Hpgw2D/R/aRq+Ah2QdPHSyK9NW8m/+kJQQQAtBbC0I9NfH97Qcn5nNEo1Pvwr2PjOKIjxk+yxHB2FK4Cex6ULhB7WrX5553ip1aa2j/TzvRIOZoOeuQnvqTyC42CKDHp0kFasxaDz5ST/KNm9kRaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekUYK4n/RzFdwDF2VM8EdRId9GGkXny82ctSJAKWJAs=;
 b=Soecacw45lYpYthoesWJDnBaSYlP+Ldyo7wC7jGhkWbO7cNIdDvBr9g43Ps66xZ//QO2n3MigBk3EhrL1ktAR8cTDW8QxeKd8tVAAYqyheQZnBVdNSMlcI6D+LSZhNrMHzX9p7FtDEk0gO+7Xlk4+3PHehNfrA0tSSJRJ6Z/w1c=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by LV8PR10MB7822.namprd10.prod.outlook.com (2603:10b6:408:1e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Thu, 5 Jun
 2025 09:33:10 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8746.041; Thu, 5 Jun 2025
 09:33:10 +0000
Date: Thu, 5 Jun 2025 10:33:07 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Barry Song <baohua@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>, Jann Horn <jannh@google.com>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2] mm/pagewalk: split walk_page_range_novma() into
 kernel/user parts
Message-ID: <49e2e517-249b-4808-abba-03cef59dc70f@lucifer.local>
References: <20250604141958.111300-1-lorenzo.stoakes@oracle.com>
 <590641e8-35f0-43e5-985a-3912c126b4aa@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <590641e8-35f0-43e5-985a-3912c126b4aa@redhat.com>
X-ClientProxiedBy: LO4P123CA0557.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|LV8PR10MB7822:EE_
X-MS-Office365-Filtering-Correlation-Id: 545346de-91b1-40f8-3194-08dda413fca7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1kKxTo3XSw8tY9i+iHzL1N2n9SNXwuQXW7ewDN9Dl/jhScmUdeL/66Q0zVB/?=
 =?us-ascii?Q?GVxBksydSDhn+mSYDsLh/bBTe4ynLwshBBYVHh5JEr3duP7donoudd/DE7Zu?=
 =?us-ascii?Q?9VujOBcvnFI4maCsX+v1sI8IX2u5bDTKfjWQYarDzb7H7fK1bE/NnldbpNGB?=
 =?us-ascii?Q?w0V5XtEOhbgSsj9brQlZqASAphm5EjbvT53gYi2K6iyigQ/NgJDDBkZBcXe0?=
 =?us-ascii?Q?w5zSkvkKOCgoLOCzEUt8dTQYEJv7TxN1G/MV72gdI0pdo+S/O9EsM3C+OZMk?=
 =?us-ascii?Q?7U4U37OrZvWZ0X2azFtnlOISH5hXPuv28pyCTV6heeETRR0hKmUTXR0MN1hd?=
 =?us-ascii?Q?Pl4umWHvhMeJE/WMlws/6b1brY98ZRn+i8hockkDwL1wsFkXi5vhGwLg7r+i?=
 =?us-ascii?Q?QIWaWCwJ0bfgidh3E2iTXwoQ42Rt/71AUuh6zvsvelXOHM1+rJ6D4tp27leC?=
 =?us-ascii?Q?VxbSUTeZ7LoDZ3bKT+sKKombYJwkTVb+pj0rWOU8mFtOp2hQm0/NelNGdz+Q?=
 =?us-ascii?Q?u/B1Jq0EifYdG5zCQVDXNNi8OmHGOLD3mhY8/JBBFKLdl3RADPwE+azs3lKH?=
 =?us-ascii?Q?F+swDvLDHzUXjfSjHHQ/WlcZfGRJK9GZj7HhObflK87FDhFrPPNqp7g7PHMy?=
 =?us-ascii?Q?3DRHUGGz0zuPtJiRz/qM6Sq53QaBAqTcYGOf8CkS0yLga3dwOLY7wv6TPVmP?=
 =?us-ascii?Q?BTMVbOt7DABWZ3ydB7UR098zh5L1SXkzR1WRacgQQoAdi0SOs+9QolF/E5Uz?=
 =?us-ascii?Q?uN+wk6WIvaYcZogjqXTwli9NDXqSqNsOLTlRXDAV7qyJyabYI4ojaVgKmVMG?=
 =?us-ascii?Q?quqbO6bHgb6rwgplsTmOQPt5C+9LszUObGVt0b2hRVmOMKbYvFWY0EPFXFXN?=
 =?us-ascii?Q?Z78k+4DD6a3Gp5KxFplGtwRLjWHnulV7w7USM/jyyGTJToPwqDl1CG6rELUG?=
 =?us-ascii?Q?RDm5XFqW7TkDct0cl6k8BBogkIYZ7yujQqonYFHg4wGn9san2gXY2FhZCDia?=
 =?us-ascii?Q?sI1fLoyzeGyWT3IYeAMfOubVwd18pKhBBfEolwc9gEDqGxnu1C8jJsIZdtj7?=
 =?us-ascii?Q?taBspnzF6qMxvnGAg67tcvyKt2nInep+20T2HOB7pj79/Np9jvv0djxfMcAQ?=
 =?us-ascii?Q?gEiMPRME6ZRsRPzjWWafcKfBFWKxzDDdJZmZ/ATyyyxmli+AShym/2jgviIQ?=
 =?us-ascii?Q?bsXYYcFEzppv1OtXMa9fJ7eQotBZ23YrRc9+9eR9v9CI264JHHnt0GZVAAAb?=
 =?us-ascii?Q?ePjSwzafGK8kBhVDS9aSY4V6fiEtH6Jj85aW2/xdZP1x9KoluN8LWRD7Q+MA?=
 =?us-ascii?Q?tMS4IPgrJ9b0T7ZwlxbfGuLC90xnuuh07+P2XyYwNVwHzvCkos/7muXD/1ho?=
 =?us-ascii?Q?ojfg3vgeiv+3d8SGoK/ueORwGZjtZ1eD8uaBkLN6TkjOWRp7fA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wy7Bq2lAXj2TqB5H5ZBwzLSY+pBuj7PrSOHZ6ZXYUSijlAkXf1AMNd9KdtHG?=
 =?us-ascii?Q?Cv1rfBpMIakCL8EDOq3crtwgyBB5GQ+lt8kW/fwKok2HXGUAF6i96/UHAuSN?=
 =?us-ascii?Q?p9z/xE7Cxs8BS7sNhBLD9+sJChiJixkgJfWtZ5dTJ4izSUxON7o/icmzpd4g?=
 =?us-ascii?Q?hGh/HwJR4ZoUta1SMBEVAuv4qodHnUL+MoCFt7i4ZSzDjhRO3nWC2zeCk8eQ?=
 =?us-ascii?Q?I4p+Q39hck+dDmp5meEvBPAZP8Oz8fkKum+DDaYuOagY9RTr7UUMXMXLlfKx?=
 =?us-ascii?Q?sHgilHx/pt2OmKon0whtIhHO9phJhIXcHoq9kOByB7Lri2LfFvV6cgawgGdt?=
 =?us-ascii?Q?5FOvCL+hrU7VTTEdXJaYNwhwMuVR8QnvmZkqoxIjgzMSNVCS9HM5R/mEbfa3?=
 =?us-ascii?Q?uUGdEBXTi3LzzNe9EjhKa82g0KnuUy1W4HnaxCZY2ncllucbW7P2kWtDbNYG?=
 =?us-ascii?Q?vE6Bw0L0RK/SC/7t0a1dG/ujNaTIB5uK8X1JZZuhtFwik47OXC1mEBMYiHhN?=
 =?us-ascii?Q?NPDAdQ/7Gz9yQjG24nG+G5pj7BR4pQJHtypGUSi4+tbR1YQOtbYOYeoeSN3b?=
 =?us-ascii?Q?1u2ipX1ky3wRdPWojBco7mI2rSjuA6WY7V1DjFhYvBM2SZ0uAifZPgwXvMRZ?=
 =?us-ascii?Q?RYO2C1rdQkzOc+2nrqVCSCtV+NaDajFIcBmZVH1QCGqKbKk7FAu4eYhvgm1t?=
 =?us-ascii?Q?fPfRFgtwgjQQX43KETx7lD6gC+lDjeX8IQPuvdfI8EqR0GDYo/ttFIg/yeGS?=
 =?us-ascii?Q?AyAyH1d/yFmjzSEjTWUuLK3Yb/SYi/PhleJpfAkYTlBIGfi1ulhPLAhejB+G?=
 =?us-ascii?Q?A+ifQ3KlITV+AMaOHOnza0PM6/UMLwKdqP+/UqRDmqxJEi27bCbNhkE1rcwN?=
 =?us-ascii?Q?/gYukaa9NTKmWxLCWDHzC5t6lyw3YxBNs5hNrcRbjCfJbOYRUkJwb3f3UvOF?=
 =?us-ascii?Q?h7iA4kxw0ixCZReZgo4ImQBro/+e7/8HWUx2518tBJl3H4XdrRPkVR0WSQZ0?=
 =?us-ascii?Q?6b0Z+gz4a/t8p98nNcP20Sevf60Ra9kdATvVZBi5HsZy+1qgjINhqe+wFdqS?=
 =?us-ascii?Q?icopJWrNjMqnT4KLK4rSDs7a02Xtaq3GLlLuryVnk8Xbyh2DdNWANhjNwSLw?=
 =?us-ascii?Q?XPZP1ZFdPydfQevNwx38P0FdZz8aBwG4FuJ51CruKV7AGY+LKcA2gYTQu6la?=
 =?us-ascii?Q?ofrmJ+U8q3Jj0TKBP3EAaO0V8yfVPQxSArKsJFtduUwArttzC8HvZ4plvLd7?=
 =?us-ascii?Q?TD190z1TxUlPTHis2oUEErb9FFBlDOB5tdBqnPDd53mn7ExTXCcAiACHwLU9?=
 =?us-ascii?Q?rT9nNcQFHMhSYU9lNO0rWnHyuf09V+R+fwY70Dt/fJQLTp7kSRLSD/2DOMV7?=
 =?us-ascii?Q?uPe5tN4wim7GpvsRvuagjTPYGUL6tVnzKMtVbn4QxnWb+WkapM1BjL7IG33b?=
 =?us-ascii?Q?cZPpF3aqwOy6hFMM+cj/lcDkpVLtRiGjeMuMQcVGvlxASNyT4u7Mu28MwkAY?=
 =?us-ascii?Q?TC5blVnJ/m3gwqX04c+DnZx3w3f6zvIHoUcKM9NxzLk9X3gG88ENPnk9quLd?=
 =?us-ascii?Q?Lvka6/LcwLit6n1CVYwxgep+JPoBHmeHlzfCDhYyFDGm0pHxn4jLqxYtqK2m?=
 =?us-ascii?Q?8Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DLz3flT/Ccyi+RZ0q+k2ODCRQUIJKpzqkvOUfJ26HEb2QIm85oE1jZGJx1VWVpLTZ0CbOnQuywKANRSyfwaQB917QhSi8yDEfXtrbE4PgpZuaMbrSevyNE3OoXoMeE6QFtQP+USzwBVcMEtxPDvIinwUjFcFnXm2a4y4FWrht4LG9n7XbWTOL1lwARPgacyzkCFWY/sgdYGMqAtijMgxchQkmuOOilJqt+c34+y8dTgAY2dOnpZJW1ZcAce4FJ26tVlX2yIgoorVYa7KmzkFYlQsIf7Kjv5egHT/s9G/rrB0EN74DJXNWKVLsRpV6ircEwTGtMg7LszAlCmHYvd4v9ZK2WjnQjY8BJzQn6mNvisHN8XDbMX9TzR+Jx+vtDJXLLJ9sFc9deh5CyeHIasyoRNU1QHwTeT8NDFB8HUaB0mgVUgD6U7XojJL/TPh1OLOMET1LWdpoboy+S+eyWnwXAQ0GFksf5A8cukgOhvp5x94JJCzy4gTxfDNxa/AcpLZHI1HHpvwDCw7saM3zBFlVqO2J4pkeMFw3sKFeWYPx8q6mcMhiRh+oZa0ODZFbIP8mx/XCVzBk1I5hzgJxhnd+O9X74kWBaaPPIt3qbO/lyo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 545346de-91b1-40f8-3194-08dda413fca7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 09:33:10.7645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OmEOF/eW1VkEbIALkKCRMx+U7bZ4k26Nl32TkF+yOriRrDWBReqU33HS50sfRlDENpfcroi+mf77KZCwihzoequzEJg+9MokGSlYWW1ZNo4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7822
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_02,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506050084
X-Authority-Analysis: v=2.4 cv=Va/3PEp9 c=1 sm=1 tr=0 ts=68416461 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=yDde_IM5eDDVxn_611cA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDA4NCBTYWx0ZWRfX01dFG/6ENZ+y gi/g6d7TL0wG7qYbLP67nVzOU2Yqc7FcaNgPxPG5hMUTKdPihLI7tRkRUljSwuenGbdVMa5UZr5 XdIDFiLbpsSbOfnLsNcBu3ggdNzyxEQh87BPkefjEQcs+quqJpwC1zOGx1BQDdxYrJHQn1CvgFA
 sQyU+JRTFkRSueeSP5XrA5MEVledmbr4w8TAD/oLxgA2nubgr9Vxqmism9nqGOrvwTkzMIngwkK FdkI5QFQ/+SBbLNmV79zJsYVulTGaWUXEoA2uvHj6xslZm3G0kU509nf9iyJZifYfk6hmHTxqnM KMmXQIk9tjeWicI4/kVt8pBgzYie5yoI35fk6TOyB4hGlOEOd+59tcOdZWAYUDkYMYVrHCM04tN
 lPCLTYqu+znEiSnRWsV6hSc6DLzXcwN/AGQnXEUoCr5gGlRhly0IWfBz/gVmH+wVY6er0oOh
X-Proofpoint-ORIG-GUID: BU-1cO-_mw17yyJF56HkuVBS_qMBGVOT
X-Proofpoint-GUID: BU-1cO-_mw17yyJF56HkuVBS_qMBGVOT

On Thu, Jun 05, 2025 at 09:45:47AM +0200, David Hildenbrand wrote:
> On 04.06.25 16:19, Lorenzo Stoakes wrote:
> > The walk_page_range_novma() function is rather confusing - it supports two
> > modes, one used often, the other used only for debugging.
> >
> > The first mode is the common case of traversal of kernel page tables, which
> > is what nearly all callers use this for.
> >
> > Secondly it provides an unusual debugging interface that allows for the
> > traversal of page tables in a userland range of memory even for that memory
> > which is not described by a VMA.
> >
> > It is far from certain that such page tables should even exist, but perhaps
> > this is precisely why it is useful as a debugging mechanism.
> >
> > As a result, this is utilised by ptdump only. Historically, things were
> > reversed - ptdump was the only user, and other parts of the kernel evolved
> > to use the kernel page table walking here.
> >
> > Since we have some complicated and confusing locking rules for the novma
> > case, it makes sense to separate the two usages into their own functions.
> >
> > Doing this also provide self-documentation as to the intent of the caller -
> > are they doing something rather unusual or are they simply doing a standard
> > kernel page table walk?
> >
> > We therefore establish two separate functions - walk_page_range_debug() for
> > this single usage, and walk_kernel_page_table_range() for general kernel
> > page table walking.
> >
> > We additionally make walk_page_range_debug() internal to mm.
> >
> > Note that ptdump uses the precise same function for kernel walking as a
> > convenience, so we permit this but make it very explicit by having
> > walk_page_range_novma() invoke walk_kernel_page_table_range() in this case.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
>
>
> [...]
>
> >   bool try_get_and_clear_pmd(struct mm_struct *mm, pmd_t *pmd, pmd_t *pmdval);
> > diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> > index e478777c86e1..057a125c3bc0 100644
> > --- a/mm/pagewalk.c
> > +++ b/mm/pagewalk.c
> > @@ -584,9 +584,28 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
> >   	return walk_page_range_mm(mm, start, end, ops, private);
> >   }
> >
> > +static int __walk_page_range_novma(struct mm_struct *mm, unsigned long start,
> > +		unsigned long end, const struct mm_walk_ops *ops,
> > +		pgd_t *pgd, void *private)
> > +{
> > +	struct mm_walk walk = {
> > +		.ops		= ops,
> > +		.mm		= mm,
> > +		.pgd		= pgd,
> > +		.private	= private,
> > +		.no_vma		= true
> > +	};
> > +
> > +	if (start >= end || !walk.mm)
> > +		return -EINVAL;
> > +	if (!check_ops_valid(ops))
> > +		return -EINVAL;
>
> I'm wondering if that could be moved into walk_pgd_range().

There's stuff that gets called before walk_pgd_range(), see __walk_page_range()
for instance which will invoke ops->pre_vma() for instance.

And of course since we invoke walk_pgd_range() direct in this beautiful case,
but not in others we can't put that there either :)

>
> > +
> > +	return walk_pgd_range(start, end, &walk);
> > +}
> > +
>
> I would inline that into both functions and finally get rid of that "novma"
> ... beauty of a function.

Sure can do, I separated that out to avoid duplication, but it's not
exactly a massive amount of code so probably not too dreadful to just open
code it.

Will do this on a respin.

>
> Well, we still have the "no_vma" parameter, but that's a different thing.

Yeah...

>
> E.g.,, there is no need to check for walk.mm in the
> walk_kernel_page_table_range() case.

I feel overall there's more refactoring that could be done, obviously
overall we want to make this code do a _lot_ more when somebody has enough
time to generalise the page table walking logic for more kernel stuff :)

But of course this is all a question of time, as always...

>
> --
> Cheers,
>
> David / dhildenb
>
