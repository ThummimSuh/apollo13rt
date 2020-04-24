{ from } = require(\janus)

line-idx = from.self().and('epoch').and.subject('events')
  .all.map((self, epoch, events) ->
    return unless epoch?
    return unless events?

    # quickpath shortcut for continuous playback (likely this or next line)
    if (idx = self.get_(\line-idx))?
      return idx if (idx + 1) is events.length
      idx = 0 unless epoch >= events[idx].epoch
    idx ?= 0 # otherwise fallback to search from start.

    while ((idx + 1) < events.length) and (epoch > events[idx + 1].epoch)
      idx++
    return idx
  )

module.exports = { line-idx }
