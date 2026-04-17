struct VertexOutput {
    @builtin(position) clip_position: vec4<f32>,
    @location(0) uv: vec2<f32>,
}

@vertex

fn vs_main(
    @builtin(vertex_index) in_vertex_index: u32,
) -> VertexOutput {
    var out: VertexOutput;
// 6 vertices to make 2 triangles (a square)
    let pos = array<vec2<f32>, 6>(
        vec2<f32>(-0.5,  0.5), // Triangle 1: Top Left
        vec2<f32>(-0.5, -0.5), // Triangle 1: Bottom Left
        vec2<f32>( 0.5,  0.5), // Triangle 1: Top Right
        vec2<f32>( 0.5,  0.5), // Triangle 2: Top Right
        vec2<f32>(-0.5, -0.5), // Triangle 2: Bottom Left
        vec2<f32>( 0.5, -0.5)  // Triangle 2: Bottom Right
    );

    // this method sucks and there is probably a better way.

    let p = pos[in_vertex_index];
    out.clip_position = vec4<f32>(p, 0.0, 1.0);
    // Multiply by 2.0 so the range is -1.0 to 1.0 inside the square
    out.uv = p * 2.0; 
    return out;
}

// Fragment shader

@fragment
fn fs_main(in: VertexOutput) -> @location(0) vec4<f32> {

    // 1. Radius?
    let dist = length(in.uv);

    // cut anything outside the radius
    if (dist > 1.0) {
        discard;
    }

    // color
    return vec4<f32>(1.0, 1.0, 0.4, 1.0);

}