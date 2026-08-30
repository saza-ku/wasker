//! Small inkwell helpers shared across the compiler.

use inkwell::context::Context;
use inkwell::types::{BasicTypeEnum, PointerType};
use inkwell::AddressSpace;

/// Opaque-pointer era: all pointer types are represented by the context pointer type.
pub fn ptr_type<'ctx>(context: &'ctx Context, _ty: BasicTypeEnum<'ctx>) -> PointerType<'ctx> {
    context.ptr_type(AddressSpace::default())
}
