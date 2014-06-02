; ModuleID = 'Kernels.cl'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.FLOAT3 = type { float, float, float }

define void @memset_kernel(i8 addrspace(1)* nocapture %mem_d, i16 signext %val, i32 %number_bytes) nounwind uwtable {
  %1 = tail call i32 @get_global_id(i32 0) nounwind
  %2 = trunc i16 %val to i8
  %3 = sext i32 %1 to i64
  %4 = getelementptr inbounds i8 addrspace(1)* %mem_d, i64 %3
  store i8 %2, i8 addrspace(1)* %4, align 1, !tbaa !5
  ret void
}

declare i32 @get_global_id(i32)

define void @initialize_variables(float addrspace(1)* nocapture %variables, float* nocapture %ff_variable, i32 %nelr) nounwind uwtable {
  %1 = tail call i32 @get_global_id(i32 0) nounwind
  %2 = load float* %ff_variable, align 4, !tbaa !7
  %3 = sext i32 %1 to i64
  %4 = getelementptr inbounds float addrspace(1)* %variables, i64 %3
  store float %2, float addrspace(1)* %4, align 4, !tbaa !7
  %5 = getelementptr inbounds float* %ff_variable, i64 1
  %6 = load float* %5, align 4, !tbaa !7
  %7 = add nsw i32 %1, %nelr
  %8 = sext i32 %7 to i64
  %9 = getelementptr inbounds float addrspace(1)* %variables, i64 %8
  store float %6, float addrspace(1)* %9, align 4, !tbaa !7
  %10 = getelementptr inbounds float* %ff_variable, i64 2
  %11 = load float* %10, align 4, !tbaa !7
  %12 = shl nsw i32 %nelr, 1
  %13 = add nsw i32 %12, %1
  %14 = sext i32 %13 to i64
  %15 = getelementptr inbounds float addrspace(1)* %variables, i64 %14
  store float %11, float addrspace(1)* %15, align 4, !tbaa !7
  %16 = getelementptr inbounds float* %ff_variable, i64 3
  %17 = load float* %16, align 4, !tbaa !7
  %18 = mul nsw i32 %nelr, 3
  %19 = add nsw i32 %18, %1
  %20 = sext i32 %19 to i64
  %21 = getelementptr inbounds float addrspace(1)* %variables, i64 %20
  store float %17, float addrspace(1)* %21, align 4, !tbaa !7
  %22 = getelementptr inbounds float* %ff_variable, i64 4
  %23 = load float* %22, align 4, !tbaa !7
  %24 = shl nsw i32 %nelr, 2
  %25 = add nsw i32 %24, %1
  %26 = sext i32 %25 to i64
  %27 = getelementptr inbounds float addrspace(1)* %variables, i64 %26
  store float %23, float addrspace(1)* %27, align 4, !tbaa !7
  ret void
}

define void @compute_step_factor(float addrspace(1)* nocapture %variables, float addrspace(1)* nocapture %areas, float addrspace(1)* nocapture %step_factors, i32 %nelr) nounwind uwtable {
  %1 = tail call i32 @get_global_id(i32 0) nounwind
  %2 = sext i32 %1 to i64
  %3 = getelementptr inbounds float addrspace(1)* %variables, i64 %2
  %4 = load float addrspace(1)* %3, align 4, !tbaa !7
  %5 = add nsw i32 %1, %nelr
  %6 = sext i32 %5 to i64
  %7 = getelementptr inbounds float addrspace(1)* %variables, i64 %6
  %8 = load float addrspace(1)* %7, align 4, !tbaa !7
  %9 = shl i32 %nelr, 1
  %10 = add nsw i32 %1, %9
  %11 = sext i32 %10 to i64
  %12 = getelementptr inbounds float addrspace(1)* %variables, i64 %11
  %13 = load float addrspace(1)* %12, align 4, !tbaa !7
  %14 = mul nsw i32 %nelr, 3
  %15 = add nsw i32 %1, %14
  %16 = sext i32 %15 to i64
  %17 = getelementptr inbounds float addrspace(1)* %variables, i64 %16
  %18 = load float addrspace(1)* %17, align 4, !tbaa !7
  %19 = shl i32 %nelr, 2
  %20 = add nsw i32 %1, %19
  %21 = sext i32 %20 to i64
  %22 = getelementptr inbounds float addrspace(1)* %variables, i64 %21
  %23 = load float addrspace(1)* %22, align 4, !tbaa !7
  %24 = fdiv float %8, %4, !fpmath !8
  %25 = fdiv float %13, %4, !fpmath !8
  %26 = fdiv float %18, %4, !fpmath !8
  %27 = fmul float %24, %24
  %28 = fmul float %25, %25
  %29 = fadd float %27, %28
  %30 = fmul float %26, %26
  %31 = fadd float %29, %30
  %32 = fmul float %4, 5.000000e-01
  %33 = fmul float %32, %31
  %34 = fsub float %23, %33
  %35 = fmul float %34, 0x3FD9999980000000
  %36 = fmul float %35, 0x3FF6666660000000
  %37 = fdiv float %36, %4, !fpmath !8
  %38 = tail call float @sqrtf(float %37) nounwind readnone
  %39 = getelementptr inbounds float addrspace(1)* %areas, i64 %2
  %40 = load float addrspace(1)* %39, align 4, !tbaa !7
  %41 = fpext float %40 to double
  %42 = tail call double @sqrt(double %41) nounwind readnone
  %43 = fpext float %31 to double
  %44 = tail call double @sqrt(double %43) nounwind readnone
  %45 = fpext float %38 to double
  %46 = fadd double %44, %45
  %47 = fmul double %42, %46
  %48 = fdiv double 5.000000e-01, %47
  %49 = fptrunc double %48 to float
  %50 = getelementptr inbounds float addrspace(1)* %step_factors, i64 %2
  store float %49, float addrspace(1)* %50, align 4, !tbaa !7
  ret void
}

declare double @sqrt(double) nounwind readnone

define void @compute_flux(i32 addrspace(1)* nocapture %elements_surrounding_elements, float addrspace(1)* nocapture %normals, float addrspace(1)* nocapture %variables, float* nocapture %ff_variable, float addrspace(1)* nocapture %fluxes, %struct.FLOAT3* nocapture %ff_flux_contribution_density_energy, %struct.FLOAT3* nocapture %ff_flux_contribution_momentum_x, %struct.FLOAT3* nocapture %ff_flux_contribution_momentum_y, %struct.FLOAT3* nocapture %ff_flux_contribution_momentum_z, i32 %nelr) nounwind uwtable {
  %1 = tail call i32 @get_global_id(i32 0) nounwind
  %2 = sext i32 %1 to i64
  %3 = getelementptr inbounds float addrspace(1)* %variables, i64 %2
  %4 = load float addrspace(1)* %3, align 4, !tbaa !7
  %5 = add nsw i32 %1, %nelr
  %6 = sext i32 %5 to i64
  %7 = getelementptr inbounds float addrspace(1)* %variables, i64 %6
  %8 = load float addrspace(1)* %7, align 4, !tbaa !7
  %9 = shl nsw i32 %nelr, 1
  %10 = add nsw i32 %1, %9
  %11 = sext i32 %10 to i64
  %12 = getelementptr inbounds float addrspace(1)* %variables, i64 %11
  %13 = load float addrspace(1)* %12, align 4, !tbaa !7
  %14 = mul nsw i32 %nelr, 3
  %15 = add nsw i32 %1, %14
  %16 = sext i32 %15 to i64
  %17 = getelementptr inbounds float addrspace(1)* %variables, i64 %16
  %18 = load float addrspace(1)* %17, align 4, !tbaa !7
  %19 = shl nsw i32 %nelr, 2
  %20 = add nsw i32 %1, %19
  %21 = sext i32 %20 to i64
  %22 = getelementptr inbounds float addrspace(1)* %variables, i64 %21
  %23 = load float addrspace(1)* %22, align 4, !tbaa !7
  %24 = fdiv float %8, %4, !fpmath !8
  %25 = fdiv float %13, %4, !fpmath !8
  %26 = fdiv float %18, %4, !fpmath !8
  %27 = fmul float %24, %24
  %28 = fmul float %25, %25
  %29 = fadd float %27, %28
  %30 = fmul float %26, %26
  %31 = fadd float %29, %30
  %32 = tail call float @sqrtf(float %31) nounwind readnone
  %33 = fmul float %4, 5.000000e-01
  %34 = fmul float %33, %31
  %35 = fsub float %23, %34
  %36 = fmul float %35, 0x3FD9999980000000
  %37 = fmul float %36, 0x3FF6666660000000
  %38 = fdiv float %37, %4, !fpmath !8
  %39 = tail call float @sqrtf(float %38) nounwind readnone
  %40 = fmul float %24, %8
  %41 = fadd float %40, %36
  %42 = fmul float %24, %13
  %43 = fmul float %24, %18
  %44 = fmul float %25, %13
  %45 = fadd float %44, %36
  %46 = fmul float %25, %18
  %47 = fmul float %26, %18
  %48 = fadd float %47, %36
  %49 = fadd float %23, %36
  %50 = fmul float %24, %49
  %51 = fmul float %25, %49
  %52 = fmul float %49, %26
  %53 = fpext float %32 to double
  %54 = fpext float %39 to double
  %55 = getelementptr inbounds float* %ff_variable, i64 1
  %56 = getelementptr inbounds %struct.FLOAT3* %ff_flux_contribution_density_energy, i64 0, i32 0
  %57 = getelementptr inbounds %struct.FLOAT3* %ff_flux_contribution_momentum_x, i64 0, i32 0
  %58 = getelementptr inbounds %struct.FLOAT3* %ff_flux_contribution_momentum_y, i64 0, i32 0
  %59 = getelementptr inbounds %struct.FLOAT3* %ff_flux_contribution_momentum_z, i64 0, i32 0
  %60 = getelementptr inbounds float* %ff_variable, i64 2
  %61 = getelementptr inbounds %struct.FLOAT3* %ff_flux_contribution_density_energy, i64 0, i32 1
  %62 = getelementptr inbounds %struct.FLOAT3* %ff_flux_contribution_momentum_x, i64 0, i32 1
  %63 = getelementptr inbounds %struct.FLOAT3* %ff_flux_contribution_momentum_y, i64 0, i32 1
  %64 = getelementptr inbounds %struct.FLOAT3* %ff_flux_contribution_momentum_z, i64 0, i32 1
  %65 = getelementptr inbounds float* %ff_variable, i64 3
  %66 = getelementptr inbounds %struct.FLOAT3* %ff_flux_contribution_density_energy, i64 0, i32 2
  %67 = getelementptr inbounds %struct.FLOAT3* %ff_flux_contribution_momentum_x, i64 0, i32 2
  %68 = getelementptr inbounds %struct.FLOAT3* %ff_flux_contribution_momentum_y, i64 0, i32 2
  %69 = getelementptr inbounds %struct.FLOAT3* %ff_flux_contribution_momentum_z, i64 0, i32 2
  br label %70

; <label>:70                                      ; preds = %291, %0
  %indvars.iv = phi i64 [ 0, %0 ], [ %indvars.iv.next, %291 ]
  %flux_i_density_energy.036 = phi float [ 0.000000e+00, %0 ], [ %flux_i_density_energy.1, %291 ]
  %flux_i_density.035 = phi float [ 0.000000e+00, %0 ], [ %flux_i_density.1, %291 ]
  %flux_i_momentum.2.033 = phi float [ 0.000000e+00, %0 ], [ %flux_i_momentum.2.1, %291 ]
  %flux_i_momentum.1.032 = phi float [ 0.000000e+00, %0 ], [ %flux_i_momentum.1.1, %291 ]
  %flux_i_momentum.0.031 = phi float [ 0.000000e+00, %0 ], [ %flux_i_momentum.0.1, %291 ]
  %71 = trunc i64 %indvars.iv to i32
  %72 = mul nsw i32 %71, %nelr
  %73 = add nsw i32 %72, %1
  %74 = sext i32 %73 to i64
  %75 = getelementptr inbounds i32 addrspace(1)* %elements_surrounding_elements, i64 %74
  %76 = load i32 addrspace(1)* %75, align 4, !tbaa !9
  %77 = getelementptr inbounds float addrspace(1)* %normals, i64 %74
  %78 = load float addrspace(1)* %77, align 4, !tbaa !7
  %79 = add nsw i64 %indvars.iv, 4
  %80 = trunc i64 %79 to i32
  %81 = mul nsw i32 %80, %nelr
  %82 = add nsw i32 %81, %1
  %83 = sext i32 %82 to i64
  %84 = getelementptr inbounds float addrspace(1)* %normals, i64 %83
  %85 = load float addrspace(1)* %84, align 4, !tbaa !7
  %86 = add nsw i64 %indvars.iv, 8
  %87 = trunc i64 %86 to i32
  %88 = mul nsw i32 %87, %nelr
  %89 = add nsw i32 %88, %1
  %90 = sext i32 %89 to i64
  %91 = getelementptr inbounds float addrspace(1)* %normals, i64 %90
  %92 = load float addrspace(1)* %91, align 4, !tbaa !7
  %93 = icmp sgt i32 %76, -1
  br i1 %93, label %94, label %219

; <label>:94                                      ; preds = %70
  %95 = fmul float %85, %85
  %96 = fmul float %78, %78
  %97 = fmul float %92, %92
  %98 = fadd float %96, %95
  %99 = fadd float %98, %97
  %100 = tail call float @sqrtf(float %99) nounwind readnone
  %101 = sext i32 %76 to i64
  %102 = getelementptr inbounds float addrspace(1)* %variables, i64 %101
  %103 = load float addrspace(1)* %102, align 4, !tbaa !7
  %104 = add nsw i32 %76, %nelr
  %105 = sext i32 %104 to i64
  %106 = getelementptr inbounds float addrspace(1)* %variables, i64 %105
  %107 = load float addrspace(1)* %106, align 4, !tbaa !7
  %108 = add nsw i32 %76, %9
  %109 = sext i32 %108 to i64
  %110 = getelementptr inbounds float addrspace(1)* %variables, i64 %109
  %111 = load float addrspace(1)* %110, align 4, !tbaa !7
  %112 = add nsw i32 %76, %14
  %113 = sext i32 %112 to i64
  %114 = getelementptr inbounds float addrspace(1)* %variables, i64 %113
  %115 = load float addrspace(1)* %114, align 4, !tbaa !7
  %116 = add nsw i32 %76, %19
  %117 = sext i32 %116 to i64
  %118 = getelementptr inbounds float addrspace(1)* %variables, i64 %117
  %119 = load float addrspace(1)* %118, align 4, !tbaa !7
  %120 = fdiv float %107, %103, !fpmath !8
  %121 = fdiv float %111, %103, !fpmath !8
  %122 = fdiv float %115, %103, !fpmath !8
  %123 = fmul float %120, %120
  %124 = fmul float %121, %121
  %125 = fadd float %123, %124
  %126 = fmul float %122, %122
  %127 = fadd float %125, %126
  %128 = fmul float %103, 5.000000e-01
  %129 = fmul float %128, %127
  %130 = fsub float %119, %129
  %131 = fmul float %130, 0x3FD9999980000000
  %132 = fmul float %131, 0x3FF6666660000000
  %133 = fdiv float %132, %103, !fpmath !8
  %134 = tail call float @sqrtf(float %133) nounwind readnone
  %135 = fmul float %120, %107
  %136 = fadd float %135, %131
  %137 = fmul float %120, %111
  %138 = fmul float %120, %115
  %139 = fmul float %121, %111
  %140 = fadd float %139, %131
  %141 = fmul float %121, %115
  %142 = fmul float %122, %115
  %143 = fadd float %142, %131
  %144 = fadd float %119, %131
  %145 = fmul float %120, %144
  %146 = fmul float %121, %144
  %147 = fmul float %144, %122
  %148 = fmul float %100, 0xBFC99999A0000000
  %149 = fmul float %148, 5.000000e-01
  %150 = fpext float %149 to double
  %151 = fpext float %127 to double
  %152 = tail call double @sqrt(double %151) nounwind readnone
  %153 = fadd double %53, %152
  %154 = fadd double %153, %54
  %155 = fpext float %134 to double
  %156 = fadd double %154, %155
  %157 = fmul double %150, %156
  %158 = fptrunc double %157 to float
  %159 = fsub float %4, %103
  %160 = fmul float %158, %159
  %161 = fadd float %flux_i_density.035, %160
  %162 = fsub float %23, %119
  %163 = fmul float %158, %162
  %164 = fadd float %flux_i_density_energy.036, %163
  %165 = fsub float %8, %107
  %166 = fmul float %158, %165
  %167 = fadd float %flux_i_momentum.0.031, %166
  %168 = fsub float %13, %111
  %169 = fmul float %158, %168
  %170 = fadd float %flux_i_momentum.1.032, %169
  %171 = fsub float %18, %115
  %172 = fmul float %158, %171
  %173 = fadd float %flux_i_momentum.2.033, %172
  %174 = fmul float %78, 5.000000e-01
  %175 = fadd float %107, %8
  %176 = fmul float %174, %175
  %177 = fadd float %161, %176
  %178 = fadd float %145, %50
  %179 = fmul float %174, %178
  %180 = fadd float %164, %179
  %181 = fadd float %136, %41
  %182 = fmul float %174, %181
  %183 = fadd float %167, %182
  %184 = fadd float %137, %42
  %185 = fmul float %174, %184
  %186 = fadd float %170, %185
  %187 = fadd float %138, %43
  %188 = fmul float %174, %187
  %189 = fadd float %173, %188
  %190 = fmul float %85, 5.000000e-01
  %191 = fadd float %111, %13
  %192 = fmul float %190, %191
  %193 = fadd float %177, %192
  %194 = fadd float %146, %51
  %195 = fmul float %190, %194
  %196 = fadd float %180, %195
  %197 = fmul float %190, %184
  %198 = fadd float %183, %197
  %199 = fadd float %140, %45
  %200 = fmul float %190, %199
  %201 = fadd float %186, %200
  %202 = fadd float %141, %46
  %203 = fmul float %190, %202
  %204 = fadd float %189, %203
  %205 = fmul float %92, 5.000000e-01
  %206 = fadd float %115, %18
  %207 = fmul float %205, %206
  %208 = fadd float %193, %207
  %209 = fadd float %147, %52
  %210 = fmul float %205, %209
  %211 = fadd float %196, %210
  %212 = fmul float %205, %187
  %213 = fadd float %198, %212
  %214 = fmul float %205, %202
  %215 = fadd float %201, %214
  %216 = fadd float %143, %48
  %217 = fmul float %205, %216
  %218 = fadd float %204, %217
  br label %291

; <label>:219                                     ; preds = %70
  switch i32 %76, label %291 [
    i32 -1, label %220
    i32 -2, label %227
  ]

; <label>:220                                     ; preds = %219
  %221 = fmul float %78, %36
  %222 = fadd float %flux_i_momentum.0.031, %221
  %223 = fmul float %85, %36
  %224 = fadd float %flux_i_momentum.1.032, %223
  %225 = fmul float %92, %36
  %226 = fadd float %flux_i_momentum.2.033, %225
  br label %291

; <label>:227                                     ; preds = %219
  %228 = fmul float %78, 5.000000e-01
  %229 = load float* %55, align 4, !tbaa !7
  %230 = fadd float %229, %8
  %231 = fmul float %228, %230
  %232 = fadd float %flux_i_density.035, %231
  %233 = load float* %56, align 4, !tbaa !7
  %234 = fadd float %233, %50
  %235 = fmul float %228, %234
  %236 = fadd float %flux_i_density_energy.036, %235
  %237 = load float* %57, align 4, !tbaa !7
  %238 = fadd float %237, %41
  %239 = fmul float %228, %238
  %240 = fadd float %flux_i_momentum.0.031, %239
  %241 = load float* %58, align 4, !tbaa !7
  %242 = fadd float %241, %42
  %243 = fmul float %228, %242
  %244 = fadd float %flux_i_momentum.1.032, %243
  %245 = load float* %59, align 4, !tbaa !7
  %246 = fadd float %245, %43
  %247 = fmul float %228, %246
  %248 = fadd float %flux_i_momentum.2.033, %247
  %249 = fmul float %85, 5.000000e-01
  %250 = load float* %60, align 4, !tbaa !7
  %251 = fadd float %250, %13
  %252 = fmul float %249, %251
  %253 = fadd float %232, %252
  %254 = load float* %61, align 4, !tbaa !7
  %255 = fadd float %254, %51
  %256 = fmul float %249, %255
  %257 = fadd float %236, %256
  %258 = load float* %62, align 4, !tbaa !7
  %259 = fadd float %258, %42
  %260 = fmul float %249, %259
  %261 = fadd float %240, %260
  %262 = load float* %63, align 4, !tbaa !7
  %263 = fadd float %262, %45
  %264 = fmul float %249, %263
  %265 = fadd float %244, %264
  %266 = load float* %64, align 4, !tbaa !7
  %267 = fadd float %266, %46
  %268 = fmul float %249, %267
  %269 = fadd float %248, %268
  %270 = fmul float %92, 5.000000e-01
  %271 = load float* %65, align 4, !tbaa !7
  %272 = fadd float %271, %18
  %273 = fmul float %270, %272
  %274 = fadd float %253, %273
  %275 = load float* %66, align 4, !tbaa !7
  %276 = fadd float %275, %52
  %277 = fmul float %270, %276
  %278 = fadd float %257, %277
  %279 = load float* %67, align 4, !tbaa !7
  %280 = fadd float %279, %43
  %281 = fmul float %270, %280
  %282 = fadd float %261, %281
  %283 = load float* %68, align 4, !tbaa !7
  %284 = fadd float %283, %46
  %285 = fmul float %270, %284
  %286 = fadd float %265, %285
  %287 = load float* %69, align 4, !tbaa !7
  %288 = fadd float %287, %48
  %289 = fmul float %270, %288
  %290 = fadd float %269, %289
  br label %291

; <label>:291                                     ; preds = %219, %94, %227, %220
  %flux_i_momentum.0.1 = phi float [ %213, %94 ], [ %222, %220 ], [ %282, %227 ], [ %flux_i_momentum.0.031, %219 ]
  %flux_i_momentum.1.1 = phi float [ %215, %94 ], [ %224, %220 ], [ %286, %227 ], [ %flux_i_momentum.1.032, %219 ]
  %flux_i_momentum.2.1 = phi float [ %218, %94 ], [ %226, %220 ], [ %290, %227 ], [ %flux_i_momentum.2.033, %219 ]
  %flux_i_density.1 = phi float [ %208, %94 ], [ %flux_i_density.035, %220 ], [ %274, %227 ], [ %flux_i_density.035, %219 ]
  %flux_i_density_energy.1 = phi float [ %211, %94 ], [ %flux_i_density_energy.036, %220 ], [ %278, %227 ], [ %flux_i_density_energy.036, %219 ]
  %indvars.iv.next = add i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, 4
  br i1 %exitcond, label %292, label %70

; <label>:292                                     ; preds = %291
  %293 = getelementptr inbounds float addrspace(1)* %fluxes, i64 %2
  store float %flux_i_density.1, float addrspace(1)* %293, align 4, !tbaa !7
  %294 = getelementptr inbounds float addrspace(1)* %fluxes, i64 %6
  store float %flux_i_momentum.0.1, float addrspace(1)* %294, align 4, !tbaa !7
  %295 = getelementptr inbounds float addrspace(1)* %fluxes, i64 %11
  store float %flux_i_momentum.1.1, float addrspace(1)* %295, align 4, !tbaa !7
  %296 = getelementptr inbounds float addrspace(1)* %fluxes, i64 %16
  store float %flux_i_momentum.2.1, float addrspace(1)* %296, align 4, !tbaa !7
  %297 = getelementptr inbounds float addrspace(1)* %fluxes, i64 %21
  store float %flux_i_density_energy.1, float addrspace(1)* %297, align 4, !tbaa !7
  ret void
}

define void @time_step(i32 %j, i32 %nelr, float addrspace(1)* nocapture %old_variables, float addrspace(1)* nocapture %variables, float addrspace(1)* nocapture %step_factors, float addrspace(1)* nocapture %fluxes) nounwind uwtable {
  %1 = tail call i32 @get_global_id(i32 0) nounwind
  %2 = sext i32 %1 to i64
  %3 = getelementptr inbounds float addrspace(1)* %step_factors, i64 %2
  %4 = load float addrspace(1)* %3, align 4, !tbaa !7
  %5 = sub nsw i32 4, %j
  %6 = sitofp i32 %5 to float
  %7 = fdiv float %4, %6, !fpmath !8
  %8 = getelementptr inbounds float addrspace(1)* %old_variables, i64 %2
  %9 = load float addrspace(1)* %8, align 4, !tbaa !7
  %10 = getelementptr inbounds float addrspace(1)* %fluxes, i64 %2
  %11 = load float addrspace(1)* %10, align 4, !tbaa !7
  %12 = fmul float %7, %11
  %13 = fadd float %9, %12
  %14 = getelementptr inbounds float addrspace(1)* %variables, i64 %2
  store float %13, float addrspace(1)* %14, align 4, !tbaa !7
  %15 = shl i32 %nelr, 2
  %16 = add nsw i32 %1, %15
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds float addrspace(1)* %old_variables, i64 %17
  %19 = load float addrspace(1)* %18, align 4, !tbaa !7
  %20 = getelementptr inbounds float addrspace(1)* %fluxes, i64 %17
  %21 = load float addrspace(1)* %20, align 4, !tbaa !7
  %22 = fmul float %7, %21
  %23 = fadd float %19, %22
  %24 = getelementptr inbounds float addrspace(1)* %variables, i64 %17
  store float %23, float addrspace(1)* %24, align 4, !tbaa !7
  %25 = add nsw i32 %1, %nelr
  %26 = sext i32 %25 to i64
  %27 = getelementptr inbounds float addrspace(1)* %old_variables, i64 %26
  %28 = load float addrspace(1)* %27, align 4, !tbaa !7
  %29 = getelementptr inbounds float addrspace(1)* %fluxes, i64 %26
  %30 = load float addrspace(1)* %29, align 4, !tbaa !7
  %31 = fmul float %7, %30
  %32 = fadd float %28, %31
  %33 = getelementptr inbounds float addrspace(1)* %variables, i64 %26
  store float %32, float addrspace(1)* %33, align 4, !tbaa !7
  %34 = shl i32 %nelr, 1
  %35 = add nsw i32 %1, %34
  %36 = sext i32 %35 to i64
  %37 = getelementptr inbounds float addrspace(1)* %old_variables, i64 %36
  %38 = load float addrspace(1)* %37, align 4, !tbaa !7
  %39 = getelementptr inbounds float addrspace(1)* %fluxes, i64 %36
  %40 = load float addrspace(1)* %39, align 4, !tbaa !7
  %41 = fmul float %7, %40
  %42 = fadd float %38, %41
  %43 = getelementptr inbounds float addrspace(1)* %variables, i64 %36
  store float %42, float addrspace(1)* %43, align 4, !tbaa !7
  %44 = mul nsw i32 %nelr, 3
  %45 = add nsw i32 %1, %44
  %46 = sext i32 %45 to i64
  %47 = getelementptr inbounds float addrspace(1)* %old_variables, i64 %46
  %48 = load float addrspace(1)* %47, align 4, !tbaa !7
  %49 = getelementptr inbounds float addrspace(1)* %fluxes, i64 %46
  %50 = load float addrspace(1)* %49, align 4, !tbaa !7
  %51 = fmul float %7, %50
  %52 = fadd float %48, %51
  %53 = getelementptr inbounds float addrspace(1)* %variables, i64 %46
  store float %52, float addrspace(1)* %53, align 4, !tbaa !7
  ret void
}

declare float @sqrtf(float) nounwind readnone

!opencl.kernels = !{!0, !1, !2, !3, !4}

!0 = metadata !{void (i8 addrspace(1)*, i16, i32)* @memset_kernel}
!1 = metadata !{void (float addrspace(1)*, float*, i32)* @initialize_variables}
!2 = metadata !{void (float addrspace(1)*, float addrspace(1)*, float addrspace(1)*, i32)* @compute_step_factor}
!3 = metadata !{void (i32 addrspace(1)*, float addrspace(1)*, float addrspace(1)*, float*, float addrspace(1)*, %struct.FLOAT3*, %struct.FLOAT3*, %struct.FLOAT3*, %struct.FLOAT3*, i32)* @compute_flux}
!4 = metadata !{void (i32, i32, float addrspace(1)*, float addrspace(1)*, float addrspace(1)*, float addrspace(1)*)* @time_step}
!5 = metadata !{metadata !"omnipotent char", metadata !6}
!6 = metadata !{metadata !"Simple C/C++ TBAA"}
!7 = metadata !{metadata !"float", metadata !5}
!8 = metadata !{float 2.500000e+00}
!9 = metadata !{metadata !"int", metadata !5}
