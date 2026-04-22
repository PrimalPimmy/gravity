struct VertexOutput {
    @builtin(position) clip_position: vec4<f32>,
    @location(0) color: vec3<f32>,
}

const PI: f32 = 3.141592653589793;
const SEGMENTS: u32 = 100u;
const RADIUS: f32 = 0.25;

@vertex
fn vs_main(
    @builtin(vertex_index) vertex_index: u32,
    @builtin(instance_index) instance_index: u32,
) -> VertexOutput {
    var out: VertexOutput;

    let triangle_index = vertex_index / 3u;
    let corner_index = vertex_index % 3u;

    let angle0 = 2.0 * PI * f32(triangle_index) / f32(SEGMENTS);
    let angle1 = 2.0 * PI * f32(triangle_index + 1u) / f32(SEGMENTS);

    var center: vec2<f32>;

    if (instance_index == 0u) {
        center = vec2<f32>(-0.4, 0.0);
    } else {
        center = vec2<f32>(0.4, 0.0);
    }

    let rim0 = center + RADIUS * vec2<f32>(cos(angle0), sin(angle0));
    let rim1 = center + RADIUS * vec2<f32>(cos(angle1), sin(angle1));

    var pos: vec2<f32>;

    if (corner_index == 0u) {
        pos = center;
    } else if (corner_index == 1u) {
        pos = rim0;
    } else {
        pos = rim1;
    }

    out.clip_position = vec4<f32>(pos, 0.0, 1.0);

    if (instance_index == 0u) {
        out.color = vec3<f32>(1.0, 0.0, 0.0);
    } else {
        out.color = vec3<f32>(0.0, 0.0, 1.0);
    }

    return out;
}

@fragment
fn fs_main(in: VertexOutput) -> @location(0) vec4<f32> {
    return vec4<f32>(in.color, 1.0);
}
