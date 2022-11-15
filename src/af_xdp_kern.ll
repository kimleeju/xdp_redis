; ModuleID = 'af_xdp_kern.c'
source_filename = "af_xdp_kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-n32:64-S128"
target triple = "bpf"

%struct.bpf_map_def = type { i32, i32, i32, i32, i32 }
%struct.xdp_md = type { i32, i32, i32, i32, i32 }
%struct.hdr_cursor = type { i8* }
%struct.collect_vlans = type { [2 x i16] }
%struct.ethhdr = type { [6 x i8], [6 x i8], i16 }
%struct.vlan_hdr = type { i16, i16 }

@xdp_stats_map = dso_local global %struct.bpf_map_def { i32 6, i32 4, i32 16, i32 5, i32 0 }, section "maps", align 4, !dbg !0
@xsks_map = dso_local global %struct.bpf_map_def { i32 17, i32 4, i32 4, i32 64, i32 0 }, section "maps", align 4, !dbg !53
@__const.xdp_sock_prog.____fmt = private unnamed_addr constant [18 x i8] c"aaaaaaaaaaaaaaaa\0A\00", align 1
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !63
@llvm.used = appending global [4 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_sock_prog to i8*), i8* bitcast (%struct.bpf_map_def* @xdp_stats_map to i8*), i8* bitcast (%struct.bpf_map_def* @xsks_map to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @xdp_sock_prog(%struct.xdp_md* nocapture readonly %0) #0 section "xdp_sock" !dbg !98 {
  %2 = alloca [6 x i8], align 1
  call void @llvm.dbg.declare(metadata [6 x i8]* %2, metadata !197, metadata !DIExpression()), !dbg !205
  %3 = alloca i32, align 4
  %4 = alloca [18 x i8], align 1
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !110, metadata !DIExpression()), !dbg !207
  %5 = bitcast i32* %3 to i8*, !dbg !208
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %5) #3, !dbg !208
  %6 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 4, !dbg !209
  %7 = load i32, i32* %6, align 4, !dbg !209, !tbaa !210
  call void @llvm.dbg.value(metadata i32 %7, metadata !111, metadata !DIExpression()), !dbg !207
  store i32 %7, i32* %3, align 4, !dbg !215, !tbaa !216
  call void @llvm.dbg.value(metadata i32* %3, metadata !111, metadata !DIExpression(DW_OP_deref)), !dbg !207
  %8 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.bpf_map_def* @xdp_stats_map to i8*), i8* nonnull %5) #3, !dbg !217
  call void @llvm.dbg.value(metadata i8* %8, metadata !112, metadata !DIExpression()), !dbg !207
  %9 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !218
  %10 = load i32, i32* %9, align 4, !dbg !218, !tbaa !219
  %11 = zext i32 %10 to i64, !dbg !220
  %12 = inttoptr i64 %11 to i8*, !dbg !221
  call void @llvm.dbg.value(metadata i8* %12, metadata !171, metadata !DIExpression()), !dbg !207
  %13 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !222
  %14 = load i32, i32* %13, align 4, !dbg !222, !tbaa !223
  %15 = zext i32 %14 to i64, !dbg !224
  %16 = inttoptr i64 %15 to i8*, !dbg !225
  call void @llvm.dbg.value(metadata i8* %16, metadata !172, metadata !DIExpression()), !dbg !207
  call void @llvm.dbg.value(metadata i8* %16, metadata !173, metadata !DIExpression()), !dbg !207
  call void @llvm.dbg.value(metadata %struct.hdr_cursor* undef, metadata !226, metadata !DIExpression()), !dbg !235
  call void @llvm.dbg.value(metadata i8* %12, metadata !233, metadata !DIExpression()), !dbg !235
  call void @llvm.dbg.value(metadata %struct.hdr_cursor* undef, metadata !237, metadata !DIExpression()), !dbg !262
  call void @llvm.dbg.value(metadata i8* %12, metadata !249, metadata !DIExpression()), !dbg !262
  call void @llvm.dbg.value(metadata %struct.collect_vlans* null, metadata !251, metadata !DIExpression()), !dbg !262
  call void @llvm.dbg.value(metadata i8* %16, metadata !252, metadata !DIExpression()), !dbg !262
  call void @llvm.dbg.value(metadata i32 14, metadata !253, metadata !DIExpression()), !dbg !262
  %17 = getelementptr i8, i8* %16, i64 14, !dbg !264
  %18 = icmp ugt i8* %17, %12, !dbg !266
  br i1 %18, label %131, label %19, !dbg !267

19:                                               ; preds = %1
  call void @llvm.dbg.value(metadata i8* %16, metadata !252, metadata !DIExpression()), !dbg !262
  call void @llvm.dbg.value(metadata i8* %17, metadata !173, metadata !DIExpression()), !dbg !207
  %20 = inttoptr i64 %15 to %struct.ethhdr*, !dbg !268
  call void @llvm.dbg.value(metadata i8* %17, metadata !254, metadata !DIExpression()), !dbg !262
  %21 = getelementptr inbounds i8, i8* %16, i64 12, !dbg !269
  %22 = bitcast i8* %21 to i16*, !dbg !269
  call void @llvm.dbg.value(metadata i16 undef, metadata !260, metadata !DIExpression()), !dbg !262
  call void @llvm.dbg.value(metadata i32 0, metadata !261, metadata !DIExpression()), !dbg !262
  %23 = load i16, i16* %22, align 1, !dbg !262, !tbaa !270
  call void @llvm.dbg.value(metadata i16 %23, metadata !260, metadata !DIExpression()), !dbg !262
  %24 = inttoptr i64 %11 to %struct.vlan_hdr*, !dbg !272
  %25 = getelementptr i8, i8* %16, i64 22, !dbg !277
  %26 = bitcast i8* %25 to %struct.vlan_hdr*, !dbg !277
  switch i16 %23, label %41 [
    i16 -22392, label %27
    i16 129, label %27
  ], !dbg !278

27:                                               ; preds = %19, %19
  %28 = getelementptr i8, i8* %16, i64 18, !dbg !279
  %29 = bitcast i8* %28 to %struct.vlan_hdr*, !dbg !279
  %30 = icmp ugt %struct.vlan_hdr* %29, %24, !dbg !280
  br i1 %30, label %41, label %31, !dbg !281

31:                                               ; preds = %27
  call void @llvm.dbg.value(metadata i16 undef, metadata !260, metadata !DIExpression()), !dbg !262
  %32 = getelementptr i8, i8* %16, i64 16, !dbg !282
  %33 = bitcast i8* %32 to i16*, !dbg !282
  call void @llvm.dbg.value(metadata %struct.vlan_hdr* %29, metadata !254, metadata !DIExpression()), !dbg !262
  call void @llvm.dbg.value(metadata i32 1, metadata !261, metadata !DIExpression()), !dbg !262
  %34 = load i16, i16* %33, align 1, !dbg !262, !tbaa !270
  call void @llvm.dbg.value(metadata i16 %34, metadata !260, metadata !DIExpression()), !dbg !262
  switch i16 %34, label %41 [
    i16 -22392, label %35
    i16 129, label %35
  ], !dbg !278

35:                                               ; preds = %31, %31
  %36 = icmp ugt %struct.vlan_hdr* %26, %24, !dbg !280
  br i1 %36, label %41, label %37, !dbg !281

37:                                               ; preds = %35
  call void @llvm.dbg.value(metadata i16 undef, metadata !260, metadata !DIExpression()), !dbg !262
  %38 = getelementptr i8, i8* %16, i64 20, !dbg !282
  %39 = bitcast i8* %38 to i16*, !dbg !282
  call void @llvm.dbg.value(metadata %struct.vlan_hdr* %26, metadata !254, metadata !DIExpression()), !dbg !262
  call void @llvm.dbg.value(metadata i32 2, metadata !261, metadata !DIExpression()), !dbg !262
  %40 = load i16, i16* %39, align 1, !dbg !262, !tbaa !270
  call void @llvm.dbg.value(metadata i16 %40, metadata !260, metadata !DIExpression()), !dbg !262
  br label %41

41:                                               ; preds = %19, %27, %31, %35, %37
  %42 = phi i8* [ %17, %19 ], [ %17, %27 ], [ %28, %31 ], [ %28, %35 ], [ %25, %37 ], !dbg !262
  %43 = phi i16 [ %23, %19 ], [ %23, %27 ], [ %34, %31 ], [ %34, %35 ], [ %40, %37 ], !dbg !262
  call void @llvm.dbg.value(metadata %struct.vlan_hdr* undef, metadata !254, metadata !DIExpression()), !dbg !262
  call void @llvm.dbg.value(metadata %struct.vlan_hdr* undef, metadata !254, metadata !DIExpression()), !dbg !262
  call void @llvm.dbg.value(metadata %struct.vlan_hdr* undef, metadata !254, metadata !DIExpression()), !dbg !262
  call void @llvm.dbg.value(metadata i8* %42, metadata !173, metadata !DIExpression()), !dbg !207
  call void @llvm.dbg.value(metadata i8* %42, metadata !173, metadata !DIExpression()), !dbg !207
  call void @llvm.dbg.value(metadata i16 %43, metadata !114, metadata !DIExpression()), !dbg !207
  %44 = icmp ne i16 %43, 8, !dbg !283
  %45 = getelementptr inbounds i8, i8* %42, i64 20, !dbg !285
  %46 = icmp ugt i8* %45, %12, !dbg !299
  %47 = or i1 %44, %46, !dbg !300
  call void @llvm.dbg.value(metadata %struct.hdr_cursor* undef, metadata !292, metadata !DIExpression()), !dbg !301
  call void @llvm.dbg.value(metadata i8* %12, metadata !293, metadata !DIExpression()), !dbg !301
  call void @llvm.dbg.value(metadata i8* %42, metadata !295, metadata !DIExpression()), !dbg !301
  br i1 %47, label %131, label %48, !dbg !300

48:                                               ; preds = %41
  %49 = load i8, i8* %42, align 4, !dbg !302
  %50 = shl i8 %49, 2, !dbg !303
  %51 = and i8 %50, 60, !dbg !303
  call void @llvm.dbg.value(metadata i8 %51, metadata !296, metadata !DIExpression()), !dbg !301
  %52 = icmp ult i8 %51, 20, !dbg !304
  br i1 %52, label %131, label %53, !dbg !306

53:                                               ; preds = %48
  %54 = zext i8 %51 to i64, !dbg !307
  call void @llvm.dbg.value(metadata i64 %54, metadata !296, metadata !DIExpression()), !dbg !301
  %55 = getelementptr i8, i8* %42, i64 %54, !dbg !308
  %56 = icmp ugt i8* %55, %12, !dbg !310
  br i1 %56, label %131, label %57, !dbg !311

57:                                               ; preds = %53
  call void @llvm.dbg.value(metadata i8* %55, metadata !173, metadata !DIExpression()), !dbg !207
  %58 = getelementptr inbounds i8, i8* %42, i64 9, !dbg !312
  %59 = load i8, i8* %58, align 1, !dbg !312, !tbaa !313
  call void @llvm.dbg.value(metadata i8* %55, metadata !173, metadata !DIExpression()), !dbg !207
  call void @llvm.dbg.value(metadata i8 %59, metadata !115, metadata !DIExpression()), !dbg !207
  %60 = icmp ne i8 %59, 6, !dbg !315
  %61 = getelementptr inbounds i8, i8* %55, i64 20, !dbg !316
  %62 = icmp ugt i8* %61, %12, !dbg !330
  %63 = or i1 %62, %60, !dbg !331
  call void @llvm.dbg.value(metadata %struct.hdr_cursor* undef, metadata !323, metadata !DIExpression()), !dbg !332
  call void @llvm.dbg.value(metadata i8* %12, metadata !324, metadata !DIExpression()), !dbg !332
  call void @llvm.dbg.value(metadata i8* %55, metadata !327, metadata !DIExpression()), !dbg !332
  br i1 %63, label %131, label %64, !dbg !331

64:                                               ; preds = %57
  %65 = getelementptr inbounds i8, i8* %55, i64 12, !dbg !333
  %66 = bitcast i8* %65 to i16*, !dbg !333
  %67 = load i16, i16* %66, align 4, !dbg !333
  %68 = lshr i16 %67, 2, !dbg !334
  %69 = and i16 %68, 60, !dbg !334
  call void @llvm.dbg.value(metadata i16 %69, metadata !326, metadata !DIExpression()), !dbg !332
  %70 = icmp ult i16 %69, 20, !dbg !335
  br i1 %70, label %131, label %71, !dbg !337

71:                                               ; preds = %64
  %72 = zext i16 %69 to i64, !dbg !338
  %73 = getelementptr i8, i8* %55, i64 %72, !dbg !339
  %74 = icmp ugt i8* %73, %12, !dbg !341
  br i1 %74, label %131, label %75, !dbg !342

75:                                               ; preds = %71
  call void @llvm.dbg.value(metadata i8* %73, metadata !173, metadata !DIExpression()), !dbg !207
  call void @llvm.dbg.value(metadata i8* %55, metadata !149, metadata !DIExpression()), !dbg !207
  %76 = and i16 %67, 256, !dbg !343
  %77 = icmp eq i16 %76, 0, !dbg !344
  br i1 %77, label %123, label %78, !dbg !345

78:                                               ; preds = %75
  call void @llvm.dbg.value(metadata i8* %55, metadata !149, metadata !DIExpression()), !dbg !207
  call void @llvm.dbg.value(metadata %struct.ethhdr* %20, metadata !116, metadata !DIExpression()), !dbg !207
  call void @llvm.dbg.value(metadata %struct.ethhdr* %20, metadata !203, metadata !DIExpression()) #3, !dbg !346
  %79 = getelementptr inbounds [6 x i8], [6 x i8]* %2, i64 0, i64 0, !dbg !347
  call void @llvm.lifetime.start.p0i8(i64 6, i8* nonnull %79), !dbg !347
  %80 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %20, i64 0, i32 1, i64 0, !dbg !348
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 1 dereferenceable(6) %79, i8* nonnull align 1 dereferenceable(6) %80, i64 6, i1 false) #3, !dbg !348
  %81 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %20, i64 0, i32 0, i64 0, !dbg !349
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 1 dereferenceable(6) %80, i8* nonnull align 1 dereferenceable(6) %81, i64 6, i1 false) #3, !dbg !349
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 1 dereferenceable(6) %81, i8* nonnull align 1 dereferenceable(6) %79, i64 6, i1 false) #3, !dbg !350
  call void @llvm.lifetime.end.p0i8(i64 6, i8* nonnull %79), !dbg !351
  call void @llvm.dbg.value(metadata i8* %42, metadata !130, metadata !DIExpression()), !dbg !207
  call void @llvm.dbg.value(metadata i8* %42, metadata !352, metadata !DIExpression()), !dbg !358
  %82 = getelementptr inbounds i8, i8* %42, i64 12, !dbg !360
  %83 = bitcast i8* %82 to i32*, !dbg !360
  %84 = load i32, i32* %83, align 4, !dbg !360, !tbaa !361
  call void @llvm.dbg.value(metadata i32 %84, metadata !357, metadata !DIExpression()), !dbg !358
  %85 = getelementptr inbounds i8, i8* %42, i64 16, !dbg !362
  %86 = bitcast i8* %85 to i32*, !dbg !362
  %87 = load i32, i32* %86, align 4, !dbg !362, !tbaa !363
  store i32 %87, i32* %83, align 4, !dbg !364, !tbaa !361
  store i32 %84, i32* %86, align 4, !dbg !365, !tbaa !363
  call void @llvm.dbg.value(metadata i8* %55, metadata !149, metadata !DIExpression()), !dbg !207
  call void @llvm.dbg.value(metadata i8* %55, metadata !366, metadata !DIExpression()), !dbg !372
  %88 = bitcast i8* %55 to i16*, !dbg !374
  %89 = load i16, i16* %88, align 4, !dbg !374, !tbaa !375
  call void @llvm.dbg.value(metadata i16 %89, metadata !371, metadata !DIExpression()), !dbg !372
  %90 = getelementptr inbounds i8, i8* %55, i64 2, !dbg !377
  %91 = bitcast i8* %90 to i16*, !dbg !377
  %92 = load i16, i16* %91, align 2, !dbg !377, !tbaa !378
  store i16 %92, i16* %88, align 4, !dbg !379, !tbaa !375
  store i16 %89, i16* %91, align 2, !dbg !380, !tbaa !378
  call void @llvm.dbg.value(metadata i8* %55, metadata !149, metadata !DIExpression()), !dbg !207
  %93 = getelementptr inbounds i8, i8* %55, i64 8, !dbg !381
  %94 = bitcast i8* %93 to i32*, !dbg !381
  %95 = load i32, i32* %94, align 4, !dbg !381, !tbaa !382
  call void @llvm.dbg.value(metadata i32 %95, metadata !178, metadata !DIExpression()), !dbg !383
  %96 = getelementptr inbounds i8, i8* %55, i64 4, !dbg !384
  %97 = bitcast i8* %96 to i32*, !dbg !384
  %98 = load i32, i32* %97, align 4, !dbg !384, !tbaa !385
  call void @llvm.dbg.value(metadata i32 %98, metadata !386, metadata !DIExpression()) #3, !dbg !392
  %99 = call i32 @llvm.bswap.i32(i32 %98) #3, !dbg !394
  %100 = add i32 %99, 1, !dbg !384
  call void @llvm.dbg.value(metadata i32 %100, metadata !386, metadata !DIExpression()) #3, !dbg !395
  %101 = call i32 @llvm.bswap.i32(i32 %100) #3, !dbg !397
  call void @llvm.dbg.value(metadata i8* %55, metadata !149, metadata !DIExpression()), !dbg !207
  store i32 %101, i32* %94, align 4, !dbg !398, !tbaa !382
  call void @llvm.dbg.value(metadata i8* %55, metadata !149, metadata !DIExpression()), !dbg !207
  store i32 %95, i32* %97, align 4, !dbg !399, !tbaa !385
  call void @llvm.dbg.value(metadata i8* %42, metadata !130, metadata !DIExpression()), !dbg !207
  call void @llvm.dbg.value(metadata i8* %42, metadata !188, metadata !DIExpression()), !dbg !383
  %102 = bitcast i8* %85 to i16*, !dbg !400
  %103 = load i16, i16* %102, align 4, !dbg !400, !tbaa !270
  %104 = call i16 @llvm.bswap.i16(i16 %103) #3
  call void @llvm.dbg.value(metadata i16 %104, metadata !189, metadata !DIExpression()), !dbg !383
  %105 = zext i16 %104 to i64, !dbg !401
  %106 = xor i16 %104, -1, !dbg !402
  %107 = zext i16 %106 to i64, !dbg !402
  %108 = add nuw nsw i64 %105, %107, !dbg !403
  call void @llvm.dbg.value(metadata i64 %108, metadata !186, metadata !DIExpression()), !dbg !383
  call void @llvm.dbg.value(metadata i8* %55, metadata !149, metadata !DIExpression()), !dbg !207
  %109 = getelementptr inbounds i8, i8* %55, i64 16, !dbg !404
  %110 = bitcast i8* %109 to i16*, !dbg !404
  %111 = load i16, i16* %110, align 4, !dbg !404, !tbaa !405
  %112 = call i16 @llvm.bswap.i16(i16 %111) #3
  %113 = zext i16 %112 to i64, !dbg !404
  %114 = add nuw nsw i64 %108, %113, !dbg !406
  call void @llvm.dbg.value(metadata i64 %114, metadata !186, metadata !DIExpression()), !dbg !383
  %115 = and i64 %114, 65535, !dbg !407
  %116 = lshr i64 %114, 16, !dbg !408
  %117 = add nuw nsw i64 %115, %116, !dbg !409
  call void @llvm.dbg.value(metadata i64 %117, metadata !186, metadata !DIExpression()), !dbg !383
  %118 = lshr i64 %117, 16, !dbg !410
  %119 = add nuw nsw i64 %118, %117, !dbg !410
  %120 = trunc i64 %119 to i16, !dbg !410
  %121 = add i16 %120, -1, !dbg !410
  %122 = call i16 @llvm.bswap.i16(i16 %121) #3
  call void @llvm.dbg.value(metadata i8* %55, metadata !149, metadata !DIExpression()), !dbg !207
  store i16 %122, i16* %110, align 4, !dbg !411, !tbaa !405
  br label %131

123:                                              ; preds = %75
  %124 = and i16 %67, 2048, !dbg !412
  %125 = icmp eq i16 %124, 0, !dbg !413
  br i1 %125, label %131, label %126, !dbg !414

126:                                              ; preds = %123
  %127 = getelementptr inbounds [18 x i8], [18 x i8]* %4, i64 0, i64 0, !dbg !415
  call void @llvm.lifetime.start.p0i8(i64 18, i8* nonnull %127) #3, !dbg !415
  call void @llvm.dbg.declare(metadata [18 x i8]* %4, metadata !190, metadata !DIExpression()), !dbg !415
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 1 dereferenceable(18) %127, i8* nonnull align 1 dereferenceable(18) getelementptr inbounds ([18 x i8], [18 x i8]* @__const.xdp_sock_prog.____fmt, i64 0, i64 0), i64 18, i1 false), !dbg !415
  %128 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* nonnull %127, i32 18) #3, !dbg !415
  call void @llvm.lifetime.end.p0i8(i64 18, i8* nonnull %127) #3, !dbg !416
  %129 = load i32, i32* %3, align 4, !dbg !417, !tbaa !216
  call void @llvm.dbg.value(metadata i32 %129, metadata !111, metadata !DIExpression()), !dbg !207
  %130 = call i32 inttoptr (i64 51 to i32 (i8*, i32, i64)*)(i8* bitcast (%struct.bpf_map_def* @xsks_map to i8*), i32 %129, i64 0) #3, !dbg !418
  br label %131, !dbg !419

131:                                              ; preds = %57, %41, %71, %64, %53, %48, %1, %123, %126, %78
  %132 = phi i32 [ 3, %78 ], [ %130, %126 ], [ 2, %41 ], [ 2, %123 ], [ 2, %57 ], [ 2, %1 ], [ 2, %48 ], [ 2, %53 ], [ 2, %64 ], [ 2, %71 ], !dbg !207
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %5) #3, !dbg !420
  ret i32 %132, !dbg !420
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #2

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.bswap.i32(i32) #1

; Function Attrs: nounwind readnone speculatable willreturn
declare i16 @llvm.bswap.i16(i16) #1

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { argmemonly nounwind willreturn }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!94, !95, !96}
!llvm.ident = !{!97}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "xdp_stats_map", scope: !2, file: !93, line: 18, type: !55, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !43, globals: !52, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "af_xdp_kern.c", directory: "/home/smsin/xdp_redis/src")
!4 = !{!5, !14}
!5 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "xdp_action", file: !6, line: 2845, baseType: !7, size: 32, elements: !8)
!6 = !DIFile(filename: "../headers/linux/bpf.h", directory: "/home/smsin/xdp_redis/src")
!7 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!8 = !{!9, !10, !11, !12, !13}
!9 = !DIEnumerator(name: "XDP_ABORTED", value: 0, isUnsigned: true)
!10 = !DIEnumerator(name: "XDP_DROP", value: 1, isUnsigned: true)
!11 = !DIEnumerator(name: "XDP_PASS", value: 2, isUnsigned: true)
!12 = !DIEnumerator(name: "XDP_TX", value: 3, isUnsigned: true)
!13 = !DIEnumerator(name: "XDP_REDIRECT", value: 4, isUnsigned: true)
!14 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !15, line: 40, baseType: !7, size: 32, elements: !16)
!15 = !DIFile(filename: "/usr/include/netinet/in.h", directory: "")
!16 = !{!17, !18, !19, !20, !21, !22, !23, !24, !25, !26, !27, !28, !29, !30, !31, !32, !33, !34, !35, !36, !37, !38, !39, !40, !41, !42}
!17 = !DIEnumerator(name: "IPPROTO_IP", value: 0, isUnsigned: true)
!18 = !DIEnumerator(name: "IPPROTO_ICMP", value: 1, isUnsigned: true)
!19 = !DIEnumerator(name: "IPPROTO_IGMP", value: 2, isUnsigned: true)
!20 = !DIEnumerator(name: "IPPROTO_IPIP", value: 4, isUnsigned: true)
!21 = !DIEnumerator(name: "IPPROTO_TCP", value: 6, isUnsigned: true)
!22 = !DIEnumerator(name: "IPPROTO_EGP", value: 8, isUnsigned: true)
!23 = !DIEnumerator(name: "IPPROTO_PUP", value: 12, isUnsigned: true)
!24 = !DIEnumerator(name: "IPPROTO_UDP", value: 17, isUnsigned: true)
!25 = !DIEnumerator(name: "IPPROTO_IDP", value: 22, isUnsigned: true)
!26 = !DIEnumerator(name: "IPPROTO_TP", value: 29, isUnsigned: true)
!27 = !DIEnumerator(name: "IPPROTO_DCCP", value: 33, isUnsigned: true)
!28 = !DIEnumerator(name: "IPPROTO_IPV6", value: 41, isUnsigned: true)
!29 = !DIEnumerator(name: "IPPROTO_RSVP", value: 46, isUnsigned: true)
!30 = !DIEnumerator(name: "IPPROTO_GRE", value: 47, isUnsigned: true)
!31 = !DIEnumerator(name: "IPPROTO_ESP", value: 50, isUnsigned: true)
!32 = !DIEnumerator(name: "IPPROTO_AH", value: 51, isUnsigned: true)
!33 = !DIEnumerator(name: "IPPROTO_MTP", value: 92, isUnsigned: true)
!34 = !DIEnumerator(name: "IPPROTO_BEETPH", value: 94, isUnsigned: true)
!35 = !DIEnumerator(name: "IPPROTO_ENCAP", value: 98, isUnsigned: true)
!36 = !DIEnumerator(name: "IPPROTO_PIM", value: 103, isUnsigned: true)
!37 = !DIEnumerator(name: "IPPROTO_COMP", value: 108, isUnsigned: true)
!38 = !DIEnumerator(name: "IPPROTO_SCTP", value: 132, isUnsigned: true)
!39 = !DIEnumerator(name: "IPPROTO_UDPLITE", value: 136, isUnsigned: true)
!40 = !DIEnumerator(name: "IPPROTO_MPLS", value: 137, isUnsigned: true)
!41 = !DIEnumerator(name: "IPPROTO_RAW", value: 255, isUnsigned: true)
!42 = !DIEnumerator(name: "IPPROTO_MAX", value: 256, isUnsigned: true)
!43 = !{!44, !45, !46, !49, !50}
!44 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!45 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!46 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u16", file: !47, line: 24, baseType: !48)
!47 = !DIFile(filename: "/usr/include/asm-generic/int-ll64.h", directory: "")
!48 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!49 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !48, size: 64)
!50 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint16_t", file: !51, line: 40, baseType: !48)
!51 = !DIFile(filename: "/usr/include/bits/types.h", directory: "")
!52 = !{!0, !53, !63, !69, !77, !86}
!53 = !DIGlobalVariableExpression(var: !54, expr: !DIExpression())
!54 = distinct !DIGlobalVariable(name: "xsks_map", scope: !2, file: !3, line: 21, type: !55, isLocal: false, isDefinition: true)
!55 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bpf_map_def", file: !56, line: 33, size: 160, elements: !57)
!56 = !DIFile(filename: "../libbpf/src//build/usr/include/bpf/bpf_helpers.h", directory: "/home/smsin/xdp_redis/src")
!57 = !{!58, !59, !60, !61, !62}
!58 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !55, file: !56, line: 34, baseType: !7, size: 32)
!59 = !DIDerivedType(tag: DW_TAG_member, name: "key_size", scope: !55, file: !56, line: 35, baseType: !7, size: 32, offset: 32)
!60 = !DIDerivedType(tag: DW_TAG_member, name: "value_size", scope: !55, file: !56, line: 36, baseType: !7, size: 32, offset: 64)
!61 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !55, file: !56, line: 37, baseType: !7, size: 32, offset: 96)
!62 = !DIDerivedType(tag: DW_TAG_member, name: "map_flags", scope: !55, file: !56, line: 38, baseType: !7, size: 32, offset: 128)
!63 = !DIGlobalVariableExpression(var: !64, expr: !DIExpression())
!64 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 355, type: !65, isLocal: false, isDefinition: true)
!65 = !DICompositeType(tag: DW_TAG_array_type, baseType: !66, size: 32, elements: !67)
!66 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!67 = !{!68}
!68 = !DISubrange(count: 4)
!69 = !DIGlobalVariableExpression(var: !70, expr: !DIExpression())
!70 = distinct !DIGlobalVariable(name: "bpf_map_lookup_elem", scope: !2, file: !71, line: 33, type: !72, isLocal: true, isDefinition: true)
!71 = !DIFile(filename: "../libbpf/src//build/usr/include/bpf/bpf_helper_defs.h", directory: "/home/smsin/xdp_redis/src")
!72 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !73, size: 64)
!73 = !DISubroutineType(types: !74)
!74 = !{!44, !44, !75}
!75 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !76, size: 64)
!76 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!77 = !DIGlobalVariableExpression(var: !78, expr: !DIExpression())
!78 = distinct !DIGlobalVariable(name: "bpf_trace_printk", scope: !2, file: !71, line: 152, type: !79, isLocal: true, isDefinition: true)
!79 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !80, size: 64)
!80 = !DISubroutineType(types: !81)
!81 = !{!82, !83, !85, null}
!82 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!83 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !84, size: 64)
!84 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !66)
!85 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !47, line: 27, baseType: !7)
!86 = !DIGlobalVariableExpression(var: !87, expr: !DIExpression())
!87 = distinct !DIGlobalVariable(name: "bpf_redirect_map", scope: !2, file: !71, line: 1254, type: !88, isLocal: true, isDefinition: true)
!88 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !89, size: 64)
!89 = !DISubroutineType(types: !90)
!90 = !{!82, !44, !85, !91}
!91 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !47, line: 31, baseType: !92)
!92 = !DIBasicType(name: "long long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!93 = !DIFile(filename: "./../common/xdp_stats_kern.h", directory: "/home/smsin/xdp_redis/src")
!94 = !{i32 7, !"Dwarf Version", i32 4}
!95 = !{i32 2, !"Debug Info Version", i32 3}
!96 = !{i32 1, !"wchar_size", i32 4}
!97 = !{!"clang version 10.0.0-4ubuntu1 "}
!98 = distinct !DISubprogram(name: "xdp_sock_prog", scope: !3, file: !3, line: 129, type: !99, scopeLine: 130, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !109)
!99 = !DISubroutineType(types: !100)
!100 = !{!82, !101}
!101 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !102, size: 64)
!102 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 2856, size: 160, elements: !103)
!103 = !{!104, !105, !106, !107, !108}
!104 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !102, file: !6, line: 2857, baseType: !85, size: 32)
!105 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !102, file: !6, line: 2858, baseType: !85, size: 32, offset: 32)
!106 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !102, file: !6, line: 2859, baseType: !85, size: 32, offset: 64)
!107 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !102, file: !6, line: 2861, baseType: !85, size: 32, offset: 96)
!108 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !102, file: !6, line: 2862, baseType: !85, size: 32, offset: 128)
!109 = !{!110, !111, !112, !114, !115, !116, !130, !149, !171, !172, !173, !178, !186, !188, !189, !190}
!110 = !DILocalVariable(name: "ctx", arg: 1, scope: !98, file: !3, line: 129, type: !101)
!111 = !DILocalVariable(name: "index", scope: !98, file: !3, line: 131, type: !82)
!112 = !DILocalVariable(name: "pkt_count", scope: !98, file: !3, line: 134, type: !113)
!113 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !85, size: 64)
!114 = !DILocalVariable(name: "eth_type", scope: !98, file: !3, line: 147, type: !82)
!115 = !DILocalVariable(name: "ip_type", scope: !98, file: !3, line: 147, type: !82)
!116 = !DILocalVariable(name: "eth", scope: !98, file: !3, line: 148, type: !117)
!117 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !118, size: 64)
!118 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ethhdr", file: !119, line: 168, size: 112, elements: !120)
!119 = !DIFile(filename: "/usr/include/linux/if_ether.h", directory: "")
!120 = !{!121, !126, !127}
!121 = !DIDerivedType(tag: DW_TAG_member, name: "h_dest", scope: !118, file: !119, line: 169, baseType: !122, size: 48)
!122 = !DICompositeType(tag: DW_TAG_array_type, baseType: !123, size: 48, elements: !124)
!123 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!124 = !{!125}
!125 = !DISubrange(count: 6)
!126 = !DIDerivedType(tag: DW_TAG_member, name: "h_source", scope: !118, file: !119, line: 170, baseType: !122, size: 48, offset: 48)
!127 = !DIDerivedType(tag: DW_TAG_member, name: "h_proto", scope: !118, file: !119, line: 171, baseType: !128, size: 16, offset: 96)
!128 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be16", file: !129, line: 25, baseType: !46)
!129 = !DIFile(filename: "/usr/include/linux/types.h", directory: "")
!130 = !DILocalVariable(name: "iphdr", scope: !98, file: !3, line: 149, type: !131)
!131 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !132, size: 64)
!132 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iphdr", file: !133, line: 86, size: 160, elements: !134)
!133 = !DIFile(filename: "/usr/include/linux/ip.h", directory: "")
!134 = !{!135, !137, !138, !139, !140, !141, !142, !143, !144, !146, !148}
!135 = !DIDerivedType(tag: DW_TAG_member, name: "ihl", scope: !132, file: !133, line: 88, baseType: !136, size: 4, flags: DIFlagBitField, extraData: i64 0)
!136 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u8", file: !47, line: 21, baseType: !123)
!137 = !DIDerivedType(tag: DW_TAG_member, name: "version", scope: !132, file: !133, line: 89, baseType: !136, size: 4, offset: 4, flags: DIFlagBitField, extraData: i64 0)
!138 = !DIDerivedType(tag: DW_TAG_member, name: "tos", scope: !132, file: !133, line: 96, baseType: !136, size: 8, offset: 8)
!139 = !DIDerivedType(tag: DW_TAG_member, name: "tot_len", scope: !132, file: !133, line: 97, baseType: !128, size: 16, offset: 16)
!140 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !132, file: !133, line: 98, baseType: !128, size: 16, offset: 32)
!141 = !DIDerivedType(tag: DW_TAG_member, name: "frag_off", scope: !132, file: !133, line: 99, baseType: !128, size: 16, offset: 48)
!142 = !DIDerivedType(tag: DW_TAG_member, name: "ttl", scope: !132, file: !133, line: 100, baseType: !136, size: 8, offset: 64)
!143 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !132, file: !133, line: 101, baseType: !136, size: 8, offset: 72)
!144 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !132, file: !133, line: 102, baseType: !145, size: 16, offset: 80)
!145 = !DIDerivedType(tag: DW_TAG_typedef, name: "__sum16", file: !129, line: 31, baseType: !46)
!146 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !132, file: !133, line: 103, baseType: !147, size: 32, offset: 96)
!147 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be32", file: !129, line: 27, baseType: !85)
!148 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !132, file: !133, line: 104, baseType: !147, size: 32, offset: 128)
!149 = !DILocalVariable(name: "tcphdr", scope: !98, file: !3, line: 150, type: !150)
!150 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !151, size: 64)
!151 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "tcphdr", file: !152, line: 25, size: 160, elements: !153)
!152 = !DIFile(filename: "/usr/include/linux/tcp.h", directory: "")
!153 = !{!154, !155, !156, !157, !158, !159, !160, !161, !162, !163, !164, !165, !166, !167, !168, !169, !170}
!154 = !DIDerivedType(tag: DW_TAG_member, name: "source", scope: !151, file: !152, line: 26, baseType: !128, size: 16)
!155 = !DIDerivedType(tag: DW_TAG_member, name: "dest", scope: !151, file: !152, line: 27, baseType: !128, size: 16, offset: 16)
!156 = !DIDerivedType(tag: DW_TAG_member, name: "seq", scope: !151, file: !152, line: 28, baseType: !147, size: 32, offset: 32)
!157 = !DIDerivedType(tag: DW_TAG_member, name: "ack_seq", scope: !151, file: !152, line: 29, baseType: !147, size: 32, offset: 64)
!158 = !DIDerivedType(tag: DW_TAG_member, name: "res1", scope: !151, file: !152, line: 31, baseType: !46, size: 4, offset: 96, flags: DIFlagBitField, extraData: i64 96)
!159 = !DIDerivedType(tag: DW_TAG_member, name: "doff", scope: !151, file: !152, line: 32, baseType: !46, size: 4, offset: 100, flags: DIFlagBitField, extraData: i64 96)
!160 = !DIDerivedType(tag: DW_TAG_member, name: "fin", scope: !151, file: !152, line: 33, baseType: !46, size: 1, offset: 104, flags: DIFlagBitField, extraData: i64 96)
!161 = !DIDerivedType(tag: DW_TAG_member, name: "syn", scope: !151, file: !152, line: 34, baseType: !46, size: 1, offset: 105, flags: DIFlagBitField, extraData: i64 96)
!162 = !DIDerivedType(tag: DW_TAG_member, name: "rst", scope: !151, file: !152, line: 35, baseType: !46, size: 1, offset: 106, flags: DIFlagBitField, extraData: i64 96)
!163 = !DIDerivedType(tag: DW_TAG_member, name: "psh", scope: !151, file: !152, line: 36, baseType: !46, size: 1, offset: 107, flags: DIFlagBitField, extraData: i64 96)
!164 = !DIDerivedType(tag: DW_TAG_member, name: "ack", scope: !151, file: !152, line: 37, baseType: !46, size: 1, offset: 108, flags: DIFlagBitField, extraData: i64 96)
!165 = !DIDerivedType(tag: DW_TAG_member, name: "urg", scope: !151, file: !152, line: 38, baseType: !46, size: 1, offset: 109, flags: DIFlagBitField, extraData: i64 96)
!166 = !DIDerivedType(tag: DW_TAG_member, name: "ece", scope: !151, file: !152, line: 39, baseType: !46, size: 1, offset: 110, flags: DIFlagBitField, extraData: i64 96)
!167 = !DIDerivedType(tag: DW_TAG_member, name: "cwr", scope: !151, file: !152, line: 40, baseType: !46, size: 1, offset: 111, flags: DIFlagBitField, extraData: i64 96)
!168 = !DIDerivedType(tag: DW_TAG_member, name: "window", scope: !151, file: !152, line: 55, baseType: !128, size: 16, offset: 112)
!169 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !151, file: !152, line: 56, baseType: !145, size: 16, offset: 128)
!170 = !DIDerivedType(tag: DW_TAG_member, name: "urg_ptr", scope: !151, file: !152, line: 57, baseType: !128, size: 16, offset: 144)
!171 = !DILocalVariable(name: "data_end", scope: !98, file: !3, line: 151, type: !44)
!172 = !DILocalVariable(name: "data", scope: !98, file: !3, line: 152, type: !44)
!173 = !DILocalVariable(name: "nh", scope: !98, file: !3, line: 153, type: !174)
!174 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "hdr_cursor", file: !175, line: 33, size: 64, elements: !176)
!175 = !DIFile(filename: "./../common/parsing_helpers.h", directory: "/home/smsin/xdp_redis/src")
!176 = !{!177}
!177 = !DIDerivedType(tag: DW_TAG_member, name: "pos", scope: !174, file: !175, line: 34, baseType: !44, size: 64)
!178 = !DILocalVariable(name: "tmp_ack", scope: !179, file: !3, line: 184, type: !183)
!179 = distinct !DILexicalBlock(scope: !180, file: !3, line: 172, column: 24)
!180 = distinct !DILexicalBlock(scope: !181, file: !3, line: 172, column: 12)
!181 = distinct !DILexicalBlock(scope: !182, file: !3, line: 167, column: 33)
!182 = distinct !DILexicalBlock(scope: !98, file: !3, line: 167, column: 9)
!183 = !DIDerivedType(tag: DW_TAG_typedef, name: "u_int32_t", file: !184, line: 160, baseType: !185)
!184 = !DIFile(filename: "/usr/include/sys/types.h", directory: "")
!185 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint32_t", file: !51, line: 42, baseType: !7)
!186 = !DILocalVariable(name: "sum", scope: !179, file: !3, line: 200, type: !187)
!187 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!188 = !DILocalVariable(name: "iph", scope: !179, file: !3, line: 202, type: !131)
!189 = !DILocalVariable(name: "old_daddr", scope: !179, file: !3, line: 203, type: !48)
!190 = !DILocalVariable(name: "____fmt", scope: !191, file: !3, line: 268, type: !194)
!191 = distinct !DILexicalBlock(scope: !192, file: !3, line: 268, column: 13)
!192 = distinct !DILexicalBlock(scope: !193, file: !3, line: 256, column: 24)
!193 = distinct !DILexicalBlock(scope: !181, file: !3, line: 256, column: 12)
!194 = !DICompositeType(tag: DW_TAG_array_type, baseType: !66, size: 144, elements: !195)
!195 = !{!196}
!196 = !DISubrange(count: 18)
!197 = !DILocalVariable(name: "h_tmp", scope: !198, file: !199, line: 115, type: !204)
!198 = distinct !DISubprogram(name: "swap_src_dst_mac", scope: !199, file: !199, line: 113, type: !200, scopeLine: 114, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !202)
!199 = !DIFile(filename: "./../common/rewrite_helpers.h", directory: "/home/smsin/xdp_redis/src")
!200 = !DISubroutineType(types: !201)
!201 = !{null, !117}
!202 = !{!203, !197}
!203 = !DILocalVariable(name: "eth", arg: 1, scope: !198, file: !199, line: 113, type: !117)
!204 = !DICompositeType(tag: DW_TAG_array_type, baseType: !136, size: 48, elements: !124)
!205 = !DILocation(line: 115, column: 7, scope: !198, inlinedAt: !206)
!206 = distinct !DILocation(line: 180, column: 13, scope: !179)
!207 = !DILocation(line: 0, scope: !98)
!208 = !DILocation(line: 131, column: 5, scope: !98)
!209 = !DILocation(line: 131, column: 22, scope: !98)
!210 = !{!211, !212, i64 16}
!211 = !{!"xdp_md", !212, i64 0, !212, i64 4, !212, i64 8, !212, i64 12, !212, i64 16}
!212 = !{!"int", !213, i64 0}
!213 = !{!"omnipotent char", !214, i64 0}
!214 = !{!"Simple C/C++ TBAA"}
!215 = !DILocation(line: 131, column: 9, scope: !98)
!216 = !{!212, !212, i64 0}
!217 = !DILocation(line: 136, column: 17, scope: !98)
!218 = !DILocation(line: 151, column: 41, scope: !98)
!219 = !{!211, !212, i64 4}
!220 = !DILocation(line: 151, column: 30, scope: !98)
!221 = !DILocation(line: 151, column: 22, scope: !98)
!222 = !DILocation(line: 152, column: 37, scope: !98)
!223 = !{!211, !212, i64 0}
!224 = !DILocation(line: 152, column: 26, scope: !98)
!225 = !DILocation(line: 152, column: 18, scope: !98)
!226 = !DILocalVariable(name: "nh", arg: 1, scope: !227, file: !175, line: 124, type: !230)
!227 = distinct !DISubprogram(name: "parse_ethhdr", scope: !175, file: !175, line: 124, type: !228, scopeLine: 127, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !232)
!228 = !DISubroutineType(types: !229)
!229 = !{!82, !230, !44, !231}
!230 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !174, size: 64)
!231 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !117, size: 64)
!232 = !{!226, !233, !234}
!233 = !DILocalVariable(name: "data_end", arg: 2, scope: !227, file: !175, line: 125, type: !44)
!234 = !DILocalVariable(name: "ethhdr", arg: 3, scope: !227, file: !175, line: 126, type: !231)
!235 = !DILocation(line: 0, scope: !227, inlinedAt: !236)
!236 = distinct !DILocation(line: 154, column: 16, scope: !98)
!237 = !DILocalVariable(name: "nh", arg: 1, scope: !238, file: !175, line: 79, type: !230)
!238 = distinct !DISubprogram(name: "parse_ethhdr_vlan", scope: !175, file: !175, line: 79, type: !239, scopeLine: 83, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !248)
!239 = !DISubroutineType(types: !240)
!240 = !{!82, !230, !44, !231, !241}
!241 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !242, size: 64)
!242 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "collect_vlans", file: !175, line: 64, size: 32, elements: !243)
!243 = !{!244}
!244 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !242, file: !175, line: 65, baseType: !245, size: 32)
!245 = !DICompositeType(tag: DW_TAG_array_type, baseType: !46, size: 32, elements: !246)
!246 = !{!247}
!247 = !DISubrange(count: 2)
!248 = !{!237, !249, !250, !251, !252, !253, !254, !260, !261}
!249 = !DILocalVariable(name: "data_end", arg: 2, scope: !238, file: !175, line: 80, type: !44)
!250 = !DILocalVariable(name: "ethhdr", arg: 3, scope: !238, file: !175, line: 81, type: !231)
!251 = !DILocalVariable(name: "vlans", arg: 4, scope: !238, file: !175, line: 82, type: !241)
!252 = !DILocalVariable(name: "eth", scope: !238, file: !175, line: 84, type: !117)
!253 = !DILocalVariable(name: "hdrsize", scope: !238, file: !175, line: 85, type: !82)
!254 = !DILocalVariable(name: "vlh", scope: !238, file: !175, line: 86, type: !255)
!255 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !256, size: 64)
!256 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "vlan_hdr", file: !175, line: 42, size: 32, elements: !257)
!257 = !{!258, !259}
!258 = !DIDerivedType(tag: DW_TAG_member, name: "h_vlan_TCI", scope: !256, file: !175, line: 43, baseType: !128, size: 16)
!259 = !DIDerivedType(tag: DW_TAG_member, name: "h_vlan_encapsulated_proto", scope: !256, file: !175, line: 44, baseType: !128, size: 16, offset: 16)
!260 = !DILocalVariable(name: "h_proto", scope: !238, file: !175, line: 87, type: !46)
!261 = !DILocalVariable(name: "i", scope: !238, file: !175, line: 88, type: !82)
!262 = !DILocation(line: 0, scope: !238, inlinedAt: !263)
!263 = distinct !DILocation(line: 129, column: 9, scope: !227, inlinedAt: !236)
!264 = !DILocation(line: 93, column: 14, scope: !265, inlinedAt: !263)
!265 = distinct !DILexicalBlock(scope: !238, file: !175, line: 93, column: 6)
!266 = !DILocation(line: 93, column: 24, scope: !265, inlinedAt: !263)
!267 = !DILocation(line: 93, column: 6, scope: !238, inlinedAt: !263)
!268 = !DILocation(line: 97, column: 10, scope: !238, inlinedAt: !263)
!269 = !DILocation(line: 99, column: 17, scope: !238, inlinedAt: !263)
!270 = !{!271, !271, i64 0}
!271 = !{!"short", !213, i64 0}
!272 = !DILocation(line: 0, scope: !273, inlinedAt: !263)
!273 = distinct !DILexicalBlock(scope: !274, file: !175, line: 109, column: 7)
!274 = distinct !DILexicalBlock(scope: !275, file: !175, line: 105, column: 39)
!275 = distinct !DILexicalBlock(scope: !276, file: !175, line: 105, column: 2)
!276 = distinct !DILexicalBlock(scope: !238, file: !175, line: 105, column: 2)
!277 = !DILocation(line: 105, column: 2, scope: !276, inlinedAt: !263)
!278 = !DILocation(line: 106, column: 7, scope: !274, inlinedAt: !263)
!279 = !DILocation(line: 109, column: 11, scope: !273, inlinedAt: !263)
!280 = !DILocation(line: 109, column: 15, scope: !273, inlinedAt: !263)
!281 = !DILocation(line: 109, column: 7, scope: !274, inlinedAt: !263)
!282 = !DILocation(line: 112, column: 18, scope: !274, inlinedAt: !263)
!283 = !DILocation(line: 160, column: 18, scope: !284)
!284 = distinct !DILexicalBlock(scope: !98, file: !3, line: 160, column: 9)
!285 = !DILocation(line: 158, column: 10, scope: !286, inlinedAt: !297)
!286 = distinct !DILexicalBlock(scope: !287, file: !175, line: 158, column: 6)
!287 = distinct !DISubprogram(name: "parse_iphdr", scope: !175, file: !175, line: 151, type: !288, scopeLine: 154, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !291)
!288 = !DISubroutineType(types: !289)
!289 = !{!82, !230, !44, !290}
!290 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !131, size: 64)
!291 = !{!292, !293, !294, !295, !296}
!292 = !DILocalVariable(name: "nh", arg: 1, scope: !287, file: !175, line: 151, type: !230)
!293 = !DILocalVariable(name: "data_end", arg: 2, scope: !287, file: !175, line: 152, type: !44)
!294 = !DILocalVariable(name: "iphdr", arg: 3, scope: !287, file: !175, line: 153, type: !290)
!295 = !DILocalVariable(name: "iph", scope: !287, file: !175, line: 155, type: !131)
!296 = !DILocalVariable(name: "hdrsize", scope: !287, file: !175, line: 156, type: !82)
!297 = distinct !DILocation(line: 161, column: 19, scope: !298)
!298 = distinct !DILexicalBlock(scope: !284, file: !3, line: 160, column: 42)
!299 = !DILocation(line: 158, column: 14, scope: !286, inlinedAt: !297)
!300 = !DILocation(line: 156, column: 9, scope: !98)
!301 = !DILocation(line: 0, scope: !287, inlinedAt: !297)
!302 = !DILocation(line: 161, column: 17, scope: !287, inlinedAt: !297)
!303 = !DILocation(line: 161, column: 21, scope: !287, inlinedAt: !297)
!304 = !DILocation(line: 163, column: 13, scope: !305, inlinedAt: !297)
!305 = distinct !DILexicalBlock(scope: !287, file: !175, line: 163, column: 5)
!306 = !DILocation(line: 163, column: 5, scope: !287, inlinedAt: !297)
!307 = !DILocation(line: 163, column: 5, scope: !305, inlinedAt: !297)
!308 = !DILocation(line: 167, column: 14, scope: !309, inlinedAt: !297)
!309 = distinct !DILexicalBlock(scope: !287, file: !175, line: 167, column: 6)
!310 = !DILocation(line: 167, column: 24, scope: !309, inlinedAt: !297)
!311 = !DILocation(line: 167, column: 6, scope: !287, inlinedAt: !297)
!312 = !DILocation(line: 173, column: 14, scope: !287, inlinedAt: !297)
!313 = !{!314, !213, i64 9}
!314 = !{!"iphdr", !213, i64 0, !213, i64 0, !213, i64 1, !271, i64 2, !271, i64 4, !271, i64 6, !213, i64 8, !213, i64 9, !271, i64 10, !212, i64 12, !212, i64 16}
!315 = !DILocation(line: 167, column: 17, scope: !182)
!316 = !DILocation(line: 254, column: 8, scope: !317, inlinedAt: !328)
!317 = distinct !DILexicalBlock(scope: !318, file: !175, line: 254, column: 6)
!318 = distinct !DISubprogram(name: "parse_tcphdr", scope: !175, file: !175, line: 247, type: !319, scopeLine: 250, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !322)
!319 = !DISubroutineType(types: !320)
!320 = !{!82, !230, !44, !321}
!321 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !150, size: 64)
!322 = !{!323, !324, !325, !326, !327}
!323 = !DILocalVariable(name: "nh", arg: 1, scope: !318, file: !175, line: 247, type: !230)
!324 = !DILocalVariable(name: "data_end", arg: 2, scope: !318, file: !175, line: 248, type: !44)
!325 = !DILocalVariable(name: "tcphdr", arg: 3, scope: !318, file: !175, line: 249, type: !321)
!326 = !DILocalVariable(name: "len", scope: !318, file: !175, line: 251, type: !82)
!327 = !DILocalVariable(name: "h", scope: !318, file: !175, line: 252, type: !150)
!328 = distinct !DILocation(line: 169, column: 13, scope: !329)
!329 = distinct !DILexicalBlock(scope: !181, file: !3, line: 169, column: 13)
!330 = !DILocation(line: 254, column: 12, scope: !317, inlinedAt: !328)
!331 = !DILocation(line: 167, column: 9, scope: !98)
!332 = !DILocation(line: 0, scope: !318, inlinedAt: !328)
!333 = !DILocation(line: 257, column: 11, scope: !318, inlinedAt: !328)
!334 = !DILocation(line: 257, column: 16, scope: !318, inlinedAt: !328)
!335 = !DILocation(line: 259, column: 9, scope: !336, inlinedAt: !328)
!336 = distinct !DILexicalBlock(scope: !318, file: !175, line: 259, column: 5)
!337 = !DILocation(line: 259, column: 5, scope: !318, inlinedAt: !328)
!338 = !DILocation(line: 259, column: 5, scope: !336, inlinedAt: !328)
!339 = !DILocation(line: 263, column: 14, scope: !340, inlinedAt: !328)
!340 = distinct !DILexicalBlock(scope: !318, file: !175, line: 263, column: 6)
!341 = !DILocation(line: 263, column: 20, scope: !340, inlinedAt: !328)
!342 = !DILocation(line: 263, column: 6, scope: !318, inlinedAt: !328)
!343 = !DILocation(line: 172, column: 20, scope: !180)
!344 = !DILocation(line: 172, column: 12, scope: !180)
!345 = !DILocation(line: 172, column: 12, scope: !181)
!346 = !DILocation(line: 0, scope: !198, inlinedAt: !206)
!347 = !DILocation(line: 115, column: 2, scope: !198, inlinedAt: !206)
!348 = !DILocation(line: 117, column: 2, scope: !198, inlinedAt: !206)
!349 = !DILocation(line: 118, column: 2, scope: !198, inlinedAt: !206)
!350 = !DILocation(line: 119, column: 2, scope: !198, inlinedAt: !206)
!351 = !DILocation(line: 120, column: 1, scope: !198, inlinedAt: !206)
!352 = !DILocalVariable(name: "iphdr", arg: 1, scope: !353, file: !199, line: 136, type: !131)
!353 = distinct !DISubprogram(name: "swap_src_dst_ipv4", scope: !199, file: !199, line: 136, type: !354, scopeLine: 137, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !356)
!354 = !DISubroutineType(types: !355)
!355 = !{null, !131}
!356 = !{!352, !357}
!357 = !DILocalVariable(name: "tmp", scope: !353, file: !199, line: 138, type: !147)
!358 = !DILocation(line: 0, scope: !353, inlinedAt: !359)
!359 = distinct !DILocation(line: 181, column: 13, scope: !179)
!360 = !DILocation(line: 138, column: 22, scope: !353, inlinedAt: !359)
!361 = !{!314, !212, i64 12}
!362 = !DILocation(line: 140, column: 24, scope: !353, inlinedAt: !359)
!363 = !{!314, !212, i64 16}
!364 = !DILocation(line: 140, column: 15, scope: !353, inlinedAt: !359)
!365 = !DILocation(line: 141, column: 15, scope: !353, inlinedAt: !359)
!366 = !DILocalVariable(name: "tcphdr", arg: 1, scope: !367, file: !199, line: 146, type: !150)
!367 = distinct !DISubprogram(name: "swap_src_dst_tcp", scope: !199, file: !199, line: 146, type: !368, scopeLine: 147, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !370)
!368 = !DISubroutineType(types: !369)
!369 = !{null, !150}
!370 = !{!366, !371}
!371 = !DILocalVariable(name: "tmp", scope: !367, file: !199, line: 148, type: !128)
!372 = !DILocation(line: 0, scope: !367, inlinedAt: !373)
!373 = distinct !DILocation(line: 182, column: 13, scope: !179)
!374 = !DILocation(line: 148, column: 23, scope: !367, inlinedAt: !373)
!375 = !{!376, !271, i64 0}
!376 = !{!"tcphdr", !271, i64 0, !271, i64 2, !212, i64 4, !212, i64 8, !271, i64 12, !271, i64 12, !271, i64 13, !271, i64 13, !271, i64 13, !271, i64 13, !271, i64 13, !271, i64 13, !271, i64 13, !271, i64 13, !271, i64 14, !271, i64 16, !271, i64 18}
!377 = !DILocation(line: 150, column: 27, scope: !367, inlinedAt: !373)
!378 = !{!376, !271, i64 2}
!379 = !DILocation(line: 150, column: 17, scope: !367, inlinedAt: !373)
!380 = !DILocation(line: 151, column: 15, scope: !367, inlinedAt: !373)
!381 = !DILocation(line: 184, column: 41, scope: !179)
!382 = !{!376, !212, i64 8}
!383 = !DILocation(line: 0, scope: !179)
!384 = !DILocation(line: 185, column: 29, scope: !179)
!385 = !{!376, !212, i64 4}
!386 = !DILocalVariable(name: "__bsx", arg: 1, scope: !387, file: !388, line: 49, type: !185)
!387 = distinct !DISubprogram(name: "__bswap_32", scope: !388, file: !388, line: 49, type: !389, scopeLine: 50, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !391)
!388 = !DIFile(filename: "/usr/include/bits/byteswap.h", directory: "")
!389 = !DISubroutineType(types: !390)
!390 = !{!185, !185}
!391 = !{!386}
!392 = !DILocation(line: 0, scope: !387, inlinedAt: !393)
!393 = distinct !DILocation(line: 185, column: 29, scope: !179)
!394 = !DILocation(line: 54, column: 10, scope: !387, inlinedAt: !393)
!395 = !DILocation(line: 0, scope: !387, inlinedAt: !396)
!396 = distinct !DILocation(line: 185, column: 29, scope: !179)
!397 = !DILocation(line: 54, column: 10, scope: !387, inlinedAt: !396)
!398 = !DILocation(line: 185, column: 28, scope: !179)
!399 = !DILocation(line: 186, column: 25, scope: !179)
!400 = !DILocation(line: 203, column: 40, scope: !179)
!401 = !DILocation(line: 204, column: 19, scope: !179)
!402 = !DILocation(line: 204, column: 32, scope: !179)
!403 = !DILocation(line: 204, column: 29, scope: !179)
!404 = !DILocation(line: 205, column: 20, scope: !179)
!405 = !{!376, !271, i64 16}
!406 = !DILocation(line: 205, column: 17, scope: !179)
!407 = !DILocation(line: 206, column: 24, scope: !179)
!408 = !DILocation(line: 206, column: 40, scope: !179)
!409 = !DILocation(line: 206, column: 34, scope: !179)
!410 = !DILocation(line: 207, column: 29, scope: !179)
!411 = !DILocation(line: 207, column: 27, scope: !179)
!412 = !DILocation(line: 256, column: 20, scope: !193)
!413 = !DILocation(line: 256, column: 12, scope: !193)
!414 = !DILocation(line: 256, column: 12, scope: !181)
!415 = !DILocation(line: 268, column: 13, scope: !191)
!416 = !DILocation(line: 268, column: 13, scope: !192)
!417 = !DILocation(line: 270, column: 48, scope: !192)
!418 = !DILocation(line: 270, column: 20, scope: !192)
!419 = !DILocation(line: 270, column: 13, scope: !192)
!420 = !DILocation(line: 338, column: 1, scope: !98)
