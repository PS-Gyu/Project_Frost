using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraShake : MonoBehaviour
{
    [SerializeField] public float m_force = 0f;
    [SerializeField] Vector3 m_offset = Vector3.zero;

    Quaternion m_originalRot;

    // Start is called before the first frame update
    void Start()
    {
        m_originalRot = transform.rotation;
    }

    // Update is called once per frame
    void Update()
    {
        StartCoroutine(ShakeCoroutine());

    }

    IEnumerator ShakeCoroutine()
    {
        Vector3 t_originEuler = transform.eulerAngles;
        while (true)
        {
            float t_rotX = Random.Range(-m_offset.x, m_offset.x);
            float t_rotY = Random.Range(-m_offset.y, m_offset.y);
            float t_rotZ = Random.Range(-m_offset.z, m_offset.z);

            Vector3 t_randomRot = t_originEuler + new Vector3(t_rotX, t_rotY, t_rotZ);
            Quaternion t_rot = Quaternion.Euler(t_randomRot);

            while(Quaternion.Angle(transform.rotation, t_rot) > 0.1f)
            {
                transform.rotation = Quaternion.RotateTowards(transform.rotation, t_rot, m_force * Time.deltaTime);
                yield return 0;
            }
            yield return 0;


        }
    }

}
