const galleryItems = [
  { title: 'Workshop sessions', image: '/assets/training-1.jpg' },
  { title: 'Technical presentations', image: '/assets/training-2.jpg' },
  { title: 'Group coaching', image: '/assets/training-3.jpg' },
  { title: 'Hands-on practical labs', image: '/assets/training-4.jpg' }
]

function Gallery() {
  return (
    <section className="section-block gallery-block" id="gallery">
      <div className="section-header">
        <span className="eyebrow">Training Gallery</span>
        <h2>See our training environments in action</h2>
      </div>
      <div className="gallery-grid">
        {galleryItems.map((item) => (
          <div
            className="gallery-card"
            key={item.title}
            style={{ backgroundImage: `url(${item.image})` }}
          >
            <div className="gallery-overlay">
              <span>{item.title}</span>
            </div>
          </div>
        ))}
      </div>
      <p className="gallery-note">
        Replace these example images with your own photos under
        <code>/public/assets</code> to showcase your training activities.
      </p>
    </section>
  )
}

export default Gallery
