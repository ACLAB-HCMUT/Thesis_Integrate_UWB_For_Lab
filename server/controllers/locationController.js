const service = require('../services/locationService');

async function getHourlyLocations(req, res) {
  try {
    const data = await service.fetchHourly(req.params.id);
    res.json(data);
  } catch (e) {
    console.error(e);
    res.status(500).json({ message: e.message });
  }
}

async function getDailyLocations(req, res) {
  try {
    const data = await service.fetchDaily(req.params.id);
    res.json(data);
  } catch (e) {
    console.error(e);
    res.status(500).json({ message: e.message });
  }
}

async function getAnchorsLocations(req, res) {
  try {
    const data = await service.fetchAnchors(req.params.id);
    res.json(data);
  } catch (e) {
    console.error(e);
    res.status(500).json({ message: e.message });
  }
}

module.exports = { getHourlyLocations, getDailyLocations, getAnchorsLocations };
