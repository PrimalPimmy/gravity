#[repr(C)]
#[derive(Copy, Clone, Debug, bytemuck::Pod, bytemuck::Zeroable)]
pub struct Params {
    pub position: [f32; 2],
    pub radius: f32,
    pub _padding: f32, // Padding to ensure 16-byte alignment for WGSL
}
